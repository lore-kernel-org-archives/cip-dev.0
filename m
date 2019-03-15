From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 15 Mar 2019 10:17:16 +0100
Subject: [cip-dev] [PATCH] Add a console option to the kernel command
	line
In-Reply-To: <20190315063834.3788-2-akihiro27.suzuki@toshiba.co.jp>
References: <20190315063834.3788-1-akihiro27.suzuki@toshiba.co.jp>
	<20190315063834.3788-2-akihiro27.suzuki@toshiba.co.jp>
Message-ID: <a724b46c-3c8f-fe67-546a-d036dac80c7d@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 15.03.19 07:38, Akihiro Suzuki wrote:
> This option is required when starting qemu-amd64 with nographic.
> 
> Signed-off-by: Akihiro Suzuki <akihiro27.suzuki@toshiba.co.jp>
> ---
>   start-qemu.sh | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/start-qemu.sh b/start-qemu.sh
> index b71ba32..52498fa 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -79,6 +79,7 @@ INITRD_FILE=$(ls ${IMAGE_PREFIX}.initrd.img* | tail -1)
>   
>   if [ -z "${DISPLAY}" ]; then
>   	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
> +	KERNEL_CMDLINE="${KERNEL_CMDLINE} console=ttyS0"
>   fi
>   
>   shift 1
> 

Valid point. But I think this should rather go to the original, per-target 
definition of KERNEL_CMDLINE. And we can make it unconditional, ie. provide a 
uart console independent of DISPLAY settings. That's how it is on ARM[64] already.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
