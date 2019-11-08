From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 10:31:27 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 40/83] mmc: core: Add helper to see
 if a host can be retuned
In-Reply-To: <1573115572-13513-41-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-41-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191108093127.GI1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu 2019-11-07 08:32:09, Biju Das wrote:
> From: Simon Horman <horms+renesas@verge.net.au>
> 
> commit c820af5f18ec248b3cb61a9a9ce47ef0f2e9ec63 upstream.
> 
> This is in preparation for restoring saved tuning parameters
> when resuming the TMIO driver.

> @@ -515,4 +515,9 @@ static inline void mmc_retune_recheck(struct mmc_host *host)
>  		host->retune_now = 1;
>  }
>  
> +static inline bool mmc_can_retune(struct mmc_host *host)
> +{
> +	return host->can_retune == 1;
> +}
> +

Probably not worth changing any more, but it would be easier to review
if it was merged with the first user.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/b4456945/attachment.sig>
