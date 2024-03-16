# Networking

This repository has carefully planned default address prefixes configured throughout the virtual networks in [Mission Enclave Landing Zone starter](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter) and the add-ons to prevent deployment conflicts. We exepect most customers to define custom address prefixes. However, if you deploy everything "as-is", there are no overlapping address spaces and the networks will deploy without an error. Here are the default address prefixes:

## Super Network

10.0.128.0/18

## Virtual Networks

| Solution | Network                              | Address Prefix |
| -------- | ------------------------------------ | -------------- |
| MELZS    | Hub                                  | 10.0.128.0/23  |
| MELZS    | Identity                             | 10.0.130.0/24  |
| MELZS    | Operations                           | 10.0.131.0/24  |
| MELZS    | DevSecOps                            | 10.0.132.0/24  |
| MELZS    | Security                             | 10.0.133.0/24  |
| MELZS    | AMPLS                                | 10.0.134.0/27  |
| Add-On   | Workloads                            | 10.0.135.0/24  |
