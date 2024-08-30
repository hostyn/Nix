{ config, lib, ... }:

let
  cfg = config.custom.services.k3s;
in
{
  options.custom.services.k3s = {
    enable = lib.mkEnableOption "k3s";
  };

  config = lib.mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "server";
      token = "awQ4VyY6bdJUGj1l";
      clusterInit = true;
      extraFlags = toString [
        "--write-kubeconfig-mode \"0644\""
        "--disable servicelb"
        "--disable traefik"
        "--disable local-storage"
      ];
    };

    environment.etc."kube-vip.yaml" = {
      target = "/var/lib/rancher/k3s/server/manifests/kube-vip.yaml";
      text = ''
        apiVersion: v1
        kind: ServiceAccount
        metadata:
          name: kube-vip
          namespace: kube-system
        ---
        apiVersion: rbac.authorization.k8s.io/v1
        kind: ClusterRole
        metadata:
          annotations:
            rbac.authorization.kubernetes.io/autoupdate: "true"
          name: system:kube-vip-role
        rules:
          - apiGroups: [""]
            resources: ["services/status"]
            verbs: ["update"]
          - apiGroups: [""]
            resources: ["services", "endpoints"]
            verbs: ["list", "get", "watch", "update"]
          - apiGroups: [""]
            resources: ["nodes"]
            verbs: ["list", "get", "watch", "update", "patch"]
          - apiGroups: ["coordination.k8s.io"]
            resources: ["leases"]
            verbs: ["list", "get", "watch", "update", "create"]
          - apiGroups: ["discovery.k8s.io"]
            resources: ["endpointslices"]
            verbs: ["list", "get", "watch", "update"]
        ---
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: system:kube-vip-binding
        roleRef:
          apiGroup: rbac.authorization.k8s.io
          kind: ClusterRole
          name: system:kube-vip-role
        subjects:
          - kind: ServiceAccount
            name: kube-vip
            namespace: kube-system
        ---
        apiVersion: apps/v1
        kind: DaemonSet
        metadata:
          creationTimestamp: null
          labels:
            app.kubernetes.io/name: kube-vip-ds
            app.kubernetes.io/version: v0.8.2
          name: kube-vip-ds
          namespace: kube-system
        spec:
          selector:
            matchLabels:
              app.kubernetes.io/name: kube-vip-ds
          template:
            metadata:
              creationTimestamp: null
              labels:
                app.kubernetes.io/name: kube-vip-ds
                app.kubernetes.io/version: v0.8.2
            spec:
              affinity:
                nodeAffinity:
                  requiredDuringSchedulingIgnoredDuringExecution:
                    nodeSelectorTerms:
                      - matchExpressions:
                          - key: node-role.kubernetes.io/master
                            operator: Exists
                      - matchExpressions:
                          - key: node-role.kubernetes.io/control-plane
                            operator: Exists
              containers:
                - args:
                    - manager
                  env:
                    - name: vip_arp
                      value: "true"
                    - name: port
                      value: "6443"
                    - name: vip_nodename
                      valueFrom:
                        fieldRef:
                          fieldPath: spec.nodeName
                    - name: vip_interface
                      value: ens18
                    - name: vip_cidr
                      value: "32"
                    - name: dns_mode
                      value: first
                    - name: cp_enable
                      value: "true"
                    - name: cp_namespace
                      value: kube-system
                    - name: svc_enable
                      value: "true"
                    - name: svc_leasename
                      value: plndr-svcs-lock
                    - name: vip_leaderelection
                      value: "true"
                    - name: vip_leasename
                      value: plndr-cp-lock
                    - name: vip_leaseduration
                      value: "5"
                    - name: vip_renewdeadline
                      value: "3"
                    - name: vip_retryperiod
                      value: "1"
                    - name: address
                      value: 192.168.1.60
                    - name: prometheus_server
                      value: :2112
                  image: ghcr.io/kube-vip/kube-vip:v0.8.2
                  imagePullPolicy: IfNotPresent
                  name: kube-vip
                  resources: {}
                  securityContext:
                    capabilities:
                      add:
                        - NET_ADMIN
                        - NET_RAW
              hostNetwork: true
              serviceAccountName: kube-vip
              tolerations:
                - effect: NoSchedule
                  operator: Exists
                - effect: NoExecute
                  operator: Exists
          updateStrategy: {}
      '';
    };
  };
}
