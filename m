From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Mon, 29 Jan 2018 10:08:32 +0100
Subject: [cip-dev] [PATCH] Dockerfile: add iproute2
In-Reply-To: <1517214669-12918-2-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1517214669-12918-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
	<1517214669-12918-2-git-send-email-daniel.sangorrin@toshiba.co.jp>
Message-ID: <7b8deedc-b146-3d17-2c63-681ec72a956f@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

On 01/29/2018 09:31 AM, Daniel Sangorrin wrote:
> runqemu requires /sbin/ip
> 
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>

Patch applied on next. If the test build is fine I'll apply it on master.

Thanks,
Daniel

> ---
>  Dockerfile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Dockerfile b/Dockerfile
> index dbadb55..30fac76 100644
> --- a/Dockerfile
> +++ b/Dockerfile
> @@ -15,7 +15,7 @@ RUN apt-get update && \
>                         tar bzip2 curl dosfstools mtools parted \
>                         syslinux tree python3-pip bc python3-yaml \
>                         lsb-release python3-setuptools ssh-client \
> -                       vim less mercurial && \
> +                       vim less mercurial iproute2 && \
>      echo 'deb http://deb.debian.org/debian stretch main' >> /etc/apt/sources.list.d/backports.list && \
>      apt-get update && \
>      apt-get install -y -f --no-install-recommends --target-release stretch \
> 
