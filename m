From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 17 Feb 2020 13:58:04 +0100
Subject: [cip-dev] [PATCH] ci: build targz images for testing
In-Reply-To: <20200108151910.7973-1-Quirin.Gylstorff@siemens.com>
References: <20200108151910.7973-1-Quirin.Gylstorff@siemens.com>
Message-ID: <e466ed6e-3d1f-223e-b0a1-29ae6eb703ce@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 08.01.20 16:19, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .gitlab-ci.yml | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 319c5a2..523e759 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -13,17 +13,17 @@ all:
>       - export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
>       - export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
>   
> -    - kas build kas.yml:board-simatic-ipc227e.yml:opt-rt.yml
> +    - kas build kas.yml:board-simatic-ipc227e.yml:opt-rt.yml:opt-targz-img.yml
>       - scripts/deploy-cip-core.sh buster simatic-ipc227e
>   
>       - sudo rm -rf build/tmp
> -    - kas build kas.yml:board-bbb.yml:opt-rt.yml
> +    - kas build kas.yml:board-bbb.yml:opt-rt.yml:opt-targz-img.yml
>       - scripts/deploy-cip-core.sh buster bbb am335x-boneblack.dtb
>   
>       - sudo rm -rf build/tmp
> -    - kas build kas.yml:board-iwg20m.yml:opt-rt.yml
> +    - kas build kas.yml:board-iwg20m.yml:opt-rt.yml:opt-targz-img.yml
>       - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.dtb
>   
>       - sudo rm -rf build/tmp
> -    - kas build kas.yml:board-rzg2m.yml:opt-rt.yml
> +    - kas build kas.yml:board-rzg2m.yml:opt-rt.yml:opt-targz-img.yml
>       - scripts/deploy-cip-core.sh buster hihope-rz2gm r8a774a1-hihope-rzg2m-ex.dtb
> 

Thanks, applied to isar-cip-core (where this was aiming at).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
