resource "yandex_vpc_network" "diplom" {
  name = var.vpc_name
}


resource "yandex_vpc_subnet" "diplom" {
  count          = length(var.subnet_name)
  name           = var.subnet_name[count.index]
  zone           = var.zone[count.index]
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = [var.subnet_cidrs[count.index]]
}
