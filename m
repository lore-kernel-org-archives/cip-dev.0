From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 13 Jan 2020 13:46:36 +0100
Subject: [cip-dev] [isar-cip-core PATCH] classes/wic-targz-img: add
 dependency between targz-img and wic-img
In-Reply-To: <20200109143043.7675-1-Quirin.Gylstorff@siemens.com>
References: <20200109143043.7675-1-Quirin.Gylstorff@siemens.com>
Message-ID: <29667a26-8e43-a6da-4aa9-24ceb4df5145@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 09.01.20 15:30, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add a dependency between targz_image and wic_image to avoid
> an error during the generation of the targz image as wic modifies
> the rootfs.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   classes/wic-targz-img.bbclass | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/classes/wic-targz-img.bbclass b/classes/wic-targz-img.bbclass
> index 4e9f89d..1327840 100644
> --- a/classes/wic-targz-img.bbclass
> +++ b/classes/wic-targz-img.bbclass
> @@ -11,3 +11,5 @@
>   
>   inherit wic-img
>   inherit targz-img
> +
> +addtask do_targz_image after do_wic_image
> 

Applied to next, thanks.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
