From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 4 Jun 2019 08:18:05 +0200
Subject: [cip-dev] [isar-cip-core] gitignore: add kas-docker
In-Reply-To: <20190604061331.8800-1-daniel.sangorrin@toshiba.co.jp>
References: <20190604061331.8800-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <32c8eecb-2286-3cc5-61dd-538b199d6402@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 04.06.19 08:13, Daniel Sangorrin wrote:
> Add kas-docker to .gitignore so it does not show in git status
> 
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
>   .gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index fd87a39..bfedb76 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,2 +1,3 @@
>   build/
>   isar/
> +kas-docker
> \ No newline at end of file
> 

Thanks, applied.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
