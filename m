From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 10:36:37 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 41/83] mmc: tmio: Add tuning support
In-Reply-To: <1573115572-13513-42-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-42-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191108093637.GJ1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> commit 4f11997773b6b452b5a0d620c5ac5050e75c227e upstream.
> 
> Add tuning support for use with SDR104 mode
> 

> +	/* Tuning values: 1 for success, 0 for failure */
> +	DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));

I don't see why tuning should depend on register size (thus
sizeof(long)) of the host CPU. If 32 is enough, put 32 there... if
not, just use 64?

> +	if (host->tap_num * 2 >= sizeof(host->taps) * BITS_PER_BYTE) {
> +		dev_warn_once(&host->pdev->dev,
> +		      "Too many taps, skipping tuning. Please consider updating size of taps field of tmio_mmc_host\n");
> +		goto out;
> +	}

Or perhaps introduce a #define MAX_TAPS; it will be cleaner than
checking bit sizes like this.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/2fa8c8d9/attachment.sig>
