From: pavel@denx.de (Pavel Machek)
Date: Sun, 20 Oct 2019 11:48:05 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 16/57] ASoC: add for_each_dpcm_fe()
	macro
In-Reply-To: <1571295929-47286-17-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-17-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191020094805.GF8003@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> --- a/include/sound/soc-dpcm.h
> +++ b/include/sound/soc-dpcm.h
> @@ -103,6 +103,9 @@ struct snd_soc_dpcm_runtime {
>  	int trigger_pending; /* trigger cmd + 1 if pending, 0 if not */
>  };
>  
> +#define for_each_dpcm_fe(be, stream, dpcm)				\
> +	list_for_each_entry(dpcm, &(be)->dpcm[stream].fe_clients, list_fe)
> +

This macro is really confusing. dpcm is used as both control variable
of the loop and name of the field in *be. Plus it relies on list_fe
variable to be present in the context including it... that's
non-standard.

Oh and "&(be)->" can be written as "(be)." AFAICT.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191020/e45c32b7/attachment.sig>
