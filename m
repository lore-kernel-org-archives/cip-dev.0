From: pavel@denx.de (Pavel Machek)
Date: Thu, 25 Apr 2019 10:26:52 +0200
Subject: [cip-dev] [PATCH 4.19.y 06/17] usb: renesas_usbhs: Add multiple
 clocks management
In-Reply-To: <1556126440-27978-7-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1556126440-27978-7-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190425082652.GC32008@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> +	/*
> +	 * To backward compatibility with old DT, this driver checks the return
> +	 * value if it's -ENOENT or not.
> +	 */
> +	priv->clks[1] = of_clk_get(dev->of_node, 1);
> +	if (PTR_ERR(priv->clks[1]) == -ENOENT)
> +		priv->clks[1] = NULL;
> +	else if (IS_ERR(priv->clks[1]))
> +		return PTR_ERR(priv->clks[1]);

I'd really use temporary variable here.

Something like

	  if (IS_ERR()) {
	          err = PTR_ERR();
	          if (err != -ENOENT)
		         return err;
                  priv->clks[1] = NULL;
          }

But this is -cip, so no need to fix it here, but consider fixing it in
mainline.
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190425/e9cb0faf/attachment.sig>
