From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 5 Jun 2019 09:23:15 +0200
Subject: [cip-dev] [[PATCH v2]] bmap: generate bmap for wic images
In-Reply-To: <20190605071709.12908-2-daniel.sangorrin@toshiba.co.jp>
References: <20190605071709.12908-1-daniel.sangorrin@toshiba.co.jp>
	<20190605071709.12908-2-daniel.sangorrin@toshiba.co.jp>
Message-ID: <8f89f5a1-cf76-7091-b7b3-e5227fe50dee@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 05.06.19 09:17, Daniel Sangorrin wrote:
> bmap shortens the time required to flash an image.
> This can be useful when you need a fixed-size image, for
> example to update partitions with swupdate.
> 
> Example usage:
> sudo bmaptool copy --bmap \
> build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.img.bmap \
> build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.img \
> /dev/sdf
> 
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
>   meta/classes/wic-img.bbclass        | 2 ++
>   meta/conf/distro/debian-common.conf | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/meta/classes/wic-img.bbclass b/meta/classes/wic-img.bbclass
> index 86a918d..09fdfec 100644
> --- a/meta/classes/wic-img.bbclass
> +++ b/meta/classes/wic-img.bbclass
> @@ -147,9 +147,11 @@ EOSUDO
>           ${ISARROOT}/scripts/wic create ${WKS_FULL_PATH} \
>               --vars "${STAGING_DIR}/${MACHINE}/imgdata/" \
>               -o /tmp/${IMAGE_FULLNAME}.wic/ \
> +            --bmap \
>               -e ${IMAGE_BASENAME} ${WIC_CREATE_EXTRA_ARGS}
>       sudo chown -R $(stat -c "%U" ${ISARROOT}) ${ISARROOT}/meta ${ISARROOT}/meta-isar ${ISARROOT}/scripts || true
>       cp -f $(ls -t -1 ${BUILDCHROOT_DIR}/tmp/${IMAGE_FULLNAME}.wic/*.direct | head -1) ${WIC_IMAGE_FILE}
> +    cp -f $(ls -t -1 ${BUILDCHROOT_DIR}/tmp/${IMAGE_FULLNAME}.wic/*.direct.bmap | head -1) ${WIC_IMAGE_FILE}.bmap

Missed in round #1, sorry: Let's factor out the "ls | head -1" thing into a 
variable (WIC_DIRECT or so) to avoid duplicating this logic.

Jan

>   }
>   
>   do_wic_image[file-checksums] += "${WKS_FILE_CHECKSUM}"
> diff --git a/meta/conf/distro/debian-common.conf b/meta/conf/distro/debian-common.conf
> index 5a47483..b845c73 100644
> --- a/meta/conf/distro/debian-common.conf
> +++ b/meta/conf/distro/debian-common.conf
> @@ -11,7 +11,8 @@ WIC_IMAGER_INSTALL = "parted \
>                         dosfstools \
>                         mtools \
>                         e2fsprogs \
> -                      python3"
> +                      python3 \
> +                      bmap-tools"
>   
>   GRUB_BOOTLOADER_INSTALL_amd64 = "grub-efi-amd64-bin"
>   GRUB_BOOTLOADER_INSTALL_i386 = "grub-efi-ia32-bin"
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
