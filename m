From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 3 Jun 2019 09:32:26 +0200
Subject: [cip-dev] [isar-cip-core] kernel: add yml file for 4.19 kernels
In-Reply-To: <20190603072531.28135-1-daniel.sangorrin@toshiba.co.jp>
References: <20190603072531.28135-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <7d35c0d9-648c-20b8-23fa-fa4e3a0c18de@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 03.06.19 09:25, Daniel Sangorrin wrote:
> Currently 4.4 is used by default, as specified in
> conf/distro/cip-core.conf. I guess you can override
> the PREFERRED_VERSION_linux variables on the board's yaml
> but having this as build option is convenient.
> 
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
>   README.md    |  2 +-
>   opt-4.19.yml | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+), 1 deletion(-)
>   create mode 100644 opt-4.19.yml
> 
> diff --git a/README.md b/README.md
> index dfd9ef1..f90c649 100644
> --- a/README.md
> +++ b/README.md
> @@ -27,7 +27,7 @@ This image can be run using `start-qemu.sh x86`.
>   
>   The BeagleBone Black target is selected by `... kas.yml:board-bbb.yml`. In
>   order to build the image with the PREEMPT-RT kernel, append `:opt-rt.yml` to
> -the above.
> +the above. Append ':opt-4.19.yml' to use the kernel version 4.19.
>   
>   Physical targets will generate ready-to-boot images under
>   `build/tmp/deploy/images/`. To flash, e.g., the BeagleBone Black image to an SD
> diff --git a/opt-4.19.yml b/opt-4.19.yml
> new file mode 100644
> index 0000000..94306b4
> --- /dev/null
> +++ b/opt-4.19.yml
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
> +    PREFERRED_VERSION_linux-cip = "4.19.%"
> +    PREFERRED_VERSION_linux-cip-rt = "4.19.%"
> 

Thanks for looking into that - was (too) long on my todo list.

I would just turn the default around and make 4.4 opt-in.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
