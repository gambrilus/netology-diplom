resource "yandex_kubernetes_cluster" "kubercluster" {
  name        = "diplom-kuber"
  description = "diplom"

  network_id = "${yandex_vpc_network.diplom.id}"

  master {
    version = "1.28"
    zonal {
      zone      = "${yandex_vpc_subnet.diplom[0].zone}"
      subnet_id = "${yandex_vpc_subnet.diplom[0].id}"
    }

    public_ip = true

#   security_group_ids = ["${yandex_vpc_security_group.security_group_name.id}"]

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "15:00"
        duration   = "3h"
      }
    }

#   master_logging {
#      enabled = true
#      log_group_id = "${yandex_logging_group.log_group_resoruce_name.id}"
#      kube_apiserver_enabled = true
#      cluster_autoscaler_enabled = true
#      events_enabled = true
#      audit_enabled = true
#    }
  }

  service_account_id      = "${yandex_iam_service_account.sa.id}"
  node_service_account_id = "${yandex_iam_service_account.sa.id}"

  labels = {
    my_key       = "diplom-kubernetes"
    my_other_key = "diplom-kuber-cluster"
  }

  release_channel = "RAPID"
  network_policy_provider = "CALICO"

  kms_provider {
    key_id = "${yandex_kms_symmetric_key.key-a.id}"
  }
}