From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 3 Jun 2019 13:03:31 +0200
Subject: [cip-dev] [isar-cip-core] kernel: change default kernel version
 to 4.19
In-Reply-To: <20190603074118.28430-1-daniel.sangorrin@toshiba.co.jp>
References: <20190603074118.28430-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <a32b7bc1-d028-bf9c-d59b-b82754f0909f@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 03.06.19 09:41, Daniel Sangorrin wrote:
> To revert to version 4.4 users need to add :opt-4.4.yaml to
> the kas command line.
> 
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
>   README.md                 |  2 +-
>   conf/distro/cip-core.conf |  4 ++--
>   opt-4.4.yml               | 18 ++++++++++++++++++
>   3 files changed, 21 insertions(+), 3 deletions(-)
>   create mode 100644 opt-4.4.yml
> 
> diff --git a/README.md b/README.md
> index dfd9ef1..184744a 100644
> --- a/README.md
> +++ b/README.md
> @@ -27,7 +27,7 @@ This image can be run using `start-qemu.sh x86`.
>   
>   The BeagleBone Black target is selected by `... kas.yml:board-bbb.yml`. In
>   order to build the image with the PREEMPT-RT kernel, append `:opt-rt.yml` to
> -the above.
> +the above. Append ':opt-4.4.yml' to use the kernel version 4.4 instead of 4.19.
>   
>   Physical targets will generate ready-to-boot images under
>   `build/tmp/deploy/images/`. To flash, e.g., the BeagleBone Black image to an SD
> diff --git a/conf/distro/cip-core.conf b/conf/distro/cip-core.conf
> index d06ba3b..4e873de 100644
> --- a/conf/distro/cip-core.conf
> +++ b/conf/distro/cip-core.conf
> @@ -12,7 +12,7 @@
>   require conf/distro/debian-stretch.conf
>   
>   KERNEL_NAME ?= "cip"
> -PREFERRED_VERSION_linux-cip ?= "4.4.%"
> -PREFERRED_VERSION_linux-cip-rt ?= "4.4.%"
> +PREFERRED_VERSION_linux-cip ?= "4.19.%"
> +PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
>   
>   WKS_FILE ?= "${MACHINE}.wks"
> diff --git a/opt-4.4.yml b/opt-4.4.yml
> new file mode 100644
> index 0000000..87be777
> --- /dev/null
> +++ b/opt-4.4.yml
> @@ -0,0 +1,18 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba corp., 2019
> +#
> +# Authors:
> +#  Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 8
> +
> +local_conf_header:
> +  kernel-version: |
> +    PREFERRED_VERSION_linux-cip = "4.4.%"
> +    PREFERRED_VERSION_linux-cip-rt = "4.4.%"
> 

Thanks, applied.

Update the (non-rt) kernel versions at this chance as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
