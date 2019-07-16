From: pavel@denx.de (Pavel Machek)
Date: Tue, 16 Jul 2019 13:17:53 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 08/23] clk: renesas: rcar-gen3: Add
 spinlock
In-Reply-To: <1563197408-59548-9-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
	<1563197408-59548-9-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190716111753.GA24157@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> commit 875e8f6b0156c0ad56fd0c29c78e3f2f67ec0b16 upstream.
> 
> Protect the CPG register read-modify-write sequence with a spinlock.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>


> diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
> index 37be0e8..3bef9f2 100644
> --- a/drivers/clk/renesas/rcar-gen3-cpg.c
> +++ b/drivers/clk/renesas/rcar-gen3-cpg.c
> @@ -33,14 +33,19 @@
>  
>  #define CPG_RCKCR_CKSEL	BIT(15)	/* RCLK Clock Source Select */
>  
> +static spinlock_t cpg_lock;
> +

This is a bit unusual. I'd expect the the lock to be in data structure
describing the hardware... but maybe the hardware abstraction here is
so simple that we can get away with this.

>  static void cpg_reg_modify(void __iomem *reg, u32 clear, u32 set)
>  {
> +	unsigned long flags;
>  	u32 val;
>  
> +	spin_lock_irqsave(&cpg_lock, flags);
>  	val = readl(reg);
>  	val &= ~clear;
>  	val |= set;
>  	writel(val, reg);
> +	spin_unlock_irqrestore(&cpg_lock, flags);
>  };
>  
>  struct cpg_simple_notifier {

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190716/d303a019/attachment.sig>
