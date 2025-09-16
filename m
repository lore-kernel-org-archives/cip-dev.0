Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF636CAC599
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 15:03:36 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web10.766.1758035010732999759
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Sep 2025 08:03:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=IkXI0zLs;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1758034995; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hNueohNQ2odefMc2K52tL90+8mADuqJrWQ/pwb3JFVDE9Mv1L7IJVIFzaaIq3pwqk/
    lj44hetBIXi4w5aA1JTPDF8z4DBaVq19N7dD44gHya+ZGHThHTlhwEMGE9/Li4VJsPOo
    DjtlXX60V+CFegHJB0gMRw9X8ai26I9O2zQ+ru63FkXnJ+HC++J4wK69ZTmLsuOuJ2f5
    lP7r2U2hPkSnoY7Yeq6oWQIxXpCGkfEsmkJRMJ987rhx7Awr2LtiKuf35EzMJMiuua3d
    nnhgpk8n9gaqz56EBy+iFLY8hsqhSCT8DYiUOWzOFd92Yol0BUOxNTGgQXrJ4OVzoSC6
    EvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1758034995;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=KhuyRD6ff61OmAy54dpKX5Dx15s7NWDpsxx3oiV55gk=;
    b=axN++85SgI0WCVXvZyX4xpeQCPv9Jok9zwLS4i0qjHHGZ/MRH205XHy8S+UCXpumzu
    WPWa1aQcArIpxRViC/u36WI+9NBrMIlXe9u70CoWRPWjte2Z8RTqQ6tq6rIgX2RLoAqx
    cDVvY9Zf+3lVkoraBXMn0nNV9x2GvXsKjWwD6mBeKA5skBpHXXzPyC3LEQvMn8wuzRoW
    yfjdCYb4rDai1SKzoP5aJalxxqx33WAiSeiVfGe8ki41S+3sSOQn2mlcmGdtMu9PFp0i
    jCKyE29kvvauKfqzlBSigD9Yw78LHDpyMcf4QsG0X8zd+dj0hAGz/m65Fpk72Jzmmti7
    Ytwg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758034995;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=KhuyRD6ff61OmAy54dpKX5Dx15s7NWDpsxx3oiV55gk=;
    b=IkXI0zLs0FUgRZyGdFtlvXo8ysuX6u4++g3sTDuUpx77XpdDGbw6avRktgsvab2et6
    XSesGQDTNCLYRKsr+4NB+eCRzuyV37GXnxbsnycgkB8so9f20eWizHb47JbgEBXxA1fY
    Wh58fB4VT3usGb7kdR/WY1G90oAoi9QOpmzUtPbgRksP7r7Fe/LEUMqG7DkN4CO0Jflw
    Rzz2RaBjRuS5d0/XhIvd1sbDTXOl+DwBq+XXw2NZrQNMEDnT7pt1D2EoFkL44H589nSe
    wMCUrUEvEFthMyqF+hRKIzkQ/zfqoxjIkO8ZF57wt4RB8WauRMp0WoJBs7g2grWNIcdJ
    BeXg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKzK+A+UOEY="
Received: from open-xchange-core-mw-gw-7.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z025ba18GF3E7QC
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 16 Sep 2025 17:03:14 +0200 (CEST)
Date: Tue, 16 Sep 2025 17:03:14 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Message-ID: <1203971061.247035.1758034994203@webmail.strato.de>
In-Reply-To: <20250914195415.74725-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250914195415.74725-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH RESEND 4.19.y-cip] gpio: rcar: Use raw_spinlock to
 protect register access
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.83
X-Originating-Port: 49726
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Sep 2025 15:03:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20058

I might have forgotten to mention that, but the patch has been queued for t=
he next 4.19-cip already (it doesn't apply to 4.19-st). Unlike the other on=
e, you can't see it because we don't have a linux-4.19-cip-rc due to the lo=
w incoming patch rate for CIP kernels.

CU
Uli


> On 09/14/2025 9:54 PM CEST Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.ren=
esas.com> wrote:
>=20
> =20
> From: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
>=20
> commit f02c41f87cfe61440c18bf77d1ef0a884b9ee2b5 upstream.
>=20
> Use raw_spinlock in order to fix spurious messages about invalid context
> when spinlock debugging is enabled. The lock is only used to serialize
> register access.
>=20
>     [    4.239592] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     [    4.239595] [ BUG: Invalid wait context ]
>     [    4.239599] 6.13.0-rc7-arm64-renesas-05496-gd088502a519f #35 Not t=
ainted
>     [    4.239603] -----------------------------
>     [    4.239606] kworker/u8:5/76 is trying to lock:
>     [    4.239609] ffff0000091898a0 (&p->lock){....}-{3:3}, at: gpio_rcar=
_config_interrupt_input_mode+0x34/0x164
>     [    4.239641] other info that might help us debug this:
>     [    4.239643] context-{5:5}
>     [    4.239646] 5 locks held by kworker/u8:5/76:
>     [    4.239651]  #0: ffff0000080fb148 ((wq_completion)async){+.+.}-{0:=
0}, at: process_one_work+0x190/0x62c
>     [    4.250180] OF: /soc/sound@ec500000/ports/port@0/endpoint: Read of=
 boolean property 'frame-master' with a value.
>     [    4.254094]  #1: ffff80008299bd80 ((work_completion)(&entry->work)=
){+.+.}-{0:0}, at: process_one_work+0x1b8/0x62c
>     [    4.254109]  #2: ffff00000920c8f8
>     [    4.258345] OF: /soc/sound@ec500000/ports/port@1/endpoint: Read of=
 boolean property 'bitclock-master' with a value.
>     [    4.264803]  (&dev->mutex){....}-{4:4}, at: __device_attach_async_=
helper+0x3c/0xdc
>     [    4.264820]  #3: ffff00000a50ca40 (request_class#2){+.+.}-{4:4}, a=
t: __setup_irq+0xa0/0x690
>     [    4.264840]  #4:
>     [    4.268872] OF: /soc/sound@ec500000/ports/port@1/endpoint: Read of=
 boolean property 'frame-master' with a value.
>     [    4.273275] ffff00000a50c8c8 (lock_class){....}-{2:2}, at: __setup=
_irq+0xc4/0x690
>     [    4.296130] renesas_sdhi_internal_dmac ee100000.mmc: mmc1 base at =
0x00000000ee100000, max clock rate 200 MHz
>     [    4.304082] stack backtrace:
>     [    4.304086] CPU: 1 UID: 0 PID: 76 Comm: kworker/u8:5 Not tainted 6=
.13.0-rc7-arm64-renesas-05496-gd088502a519f #35
>     [    4.304092] Hardware name: Renesas Salvator-X 2nd version board ba=
sed on r8a77965 (DT)
>     [    4.304097] Workqueue: async async_run_entry_fn
>     [    4.304106] Call trace:
>     [    4.304110]  show_stack+0x14/0x20 (C)
>     [    4.304122]  dump_stack_lvl+0x6c/0x90
>     [    4.304131]  dump_stack+0x14/0x1c
>     [    4.304138]  __lock_acquire+0xdfc/0x1584
>     [    4.426274]  lock_acquire+0x1c4/0x33c
>     [    4.429942]  _raw_spin_lock_irqsave+0x5c/0x80
>     [    4.434307]  gpio_rcar_config_interrupt_input_mode+0x34/0x164
>     [    4.440061]  gpio_rcar_irq_set_type+0xd4/0xd8
>     [    4.444422]  __irq_set_trigger+0x5c/0x178
>     [    4.448435]  __setup_irq+0x2e4/0x690
>     [    4.452012]  request_threaded_irq+0xc4/0x190
>     [    4.456285]  devm_request_threaded_irq+0x7c/0xf4
>     [    4.459398] ata1: link resume succeeded after 1 retries
>     [    4.460902]  mmc_gpiod_request_cd_irq+0x68/0xe0
>     [    4.470660]  mmc_start_host+0x50/0xac
>     [    4.474327]  mmc_add_host+0x80/0xe4
>     [    4.477817]  tmio_mmc_host_probe+0x2b0/0x440
>     [    4.482094]  renesas_sdhi_probe+0x488/0x6f4
>     [    4.486281]  renesas_sdhi_internal_dmac_probe+0x60/0x78
>     [    4.491509]  platform_probe+0x64/0xd8
>     [    4.495178]  really_probe+0xb8/0x2a8
>     [    4.498756]  __driver_probe_device+0x74/0x118
>     [    4.503116]  driver_probe_device+0x3c/0x154
>     [    4.507303]  __device_attach_driver+0xd4/0x160
>     [    4.511750]  bus_for_each_drv+0x84/0xe0
>     [    4.515588]  __device_attach_async_helper+0xb0/0xdc
>     [    4.520470]  async_run_entry_fn+0x30/0xd8
>     [    4.524481]  process_one_work+0x210/0x62c
>     [    4.528494]  worker_thread+0x1ac/0x340
>     [    4.532245]  kthread+0x10c/0x110
>     [    4.535476]  ret_from_fork+0x10/0x20
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20250121135833.3769310-1-niklas.soderlund=
+renesas@ragnatech.se
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> [PL: manually applied the changes]
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
>=20
> This backport is intended to fix CVE-2025-21912 [0], as requested
> [1] resending the patch as this patch has landed into 5.10-cip
> via stable [2].
>=20
> Note,
> - This patch is already present in 6.1-cip [3] & 6.12-cip [4].
>=20
> [0] https://nvd.nist.gov/vuln/detail/CVE-2025-21912
> [1] https://lore.kernel.org/all/20250820141628.5014-1-prabhakar.mahadev-l=
ad.rj@bp.renesas.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/com=
mit/?h=3Dlinux-5.10.y-cip&id=3D389891ac9f678baf68e13623ef1308493af4b074
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/com=
mit/drivers/gpio/gpio-rcar.c?h=3Dlinux-6.1.y-cip&id=3D3e300913c42041e81c5b1=
7a970c4e078086ff2d1
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/com=
mit/drivers/gpio/gpio-rcar.c?h=3Dlinux-6.12.y-cip&id=3Db42c84f9e4ec5bc2885e=
7fd80c79ec0352f5d2af
>=20
> Cheers, Prabhakar
> ---
>  drivers/gpio/gpio-rcar.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index c8d526aed633a..f70dec0dfd830 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -42,7 +42,7 @@ struct gpio_rcar_bank_info {
> =20
>  struct gpio_rcar_priv {
>  =09void __iomem *base;
> -=09spinlock_t lock;
> +=09raw_spinlock_t lock;
>  =09struct device *dev;
>  =09struct gpio_chip gpio_chip;
>  =09struct irq_chip irq_chip;
> @@ -122,7 +122,7 @@ static void gpio_rcar_config_interrupt_input_mode(str=
uct gpio_rcar_priv *p,
>  =09 * "Setting Level-Sensitive Interrupt Input Mode"
>  =09 */
> =20
> -=09spin_lock_irqsave(&p->lock, flags);
> +=09raw_spin_lock_irqsave(&p->lock, flags);
> =20
>  =09/* Configure postive or negative logic in POSNEG */
>  =09gpio_rcar_modify_bit(p, POSNEG, hwirq, !active_high_rising_edge);
> @@ -141,7 +141,7 @@ static void gpio_rcar_config_interrupt_input_mode(str=
uct gpio_rcar_priv *p,
>  =09if (!level_trigger)
>  =09=09gpio_rcar_write(p, INTCLR, BIT(hwirq));
> =20
> -=09spin_unlock_irqrestore(&p->lock, flags);
> +=09raw_spin_unlock_irqrestore(&p->lock, flags);
>  }
> =20
>  static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
> @@ -234,7 +234,7 @@ static void gpio_rcar_config_general_input_output_mod=
e(struct gpio_chip *chip,
>  =09 * "Setting General Input Mode"
>  =09 */
> =20
> -=09spin_lock_irqsave(&p->lock, flags);
> +=09raw_spin_lock_irqsave(&p->lock, flags);
> =20
>  =09/* Configure postive logic in POSNEG */
>  =09gpio_rcar_modify_bit(p, POSNEG, gpio, false);
> @@ -249,7 +249,7 @@ static void gpio_rcar_config_general_input_output_mod=
e(struct gpio_chip *chip,
>  =09if (p->has_outdtsel && output)
>  =09=09gpio_rcar_modify_bit(p, OUTDTSEL, gpio, false);
> =20
> -=09spin_unlock_irqrestore(&p->lock, flags);
> +=09raw_spin_unlock_irqrestore(&p->lock, flags);
>  }
> =20
>  static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
> @@ -313,9 +313,9 @@ static void gpio_rcar_set(struct gpio_chip *chip, uns=
igned offset, int value)
>  =09struct gpio_rcar_priv *p =3D gpiochip_get_data(chip);
>  =09unsigned long flags;
> =20
> -=09spin_lock_irqsave(&p->lock, flags);
> +=09raw_spin_lock_irqsave(&p->lock, flags);
>  =09gpio_rcar_modify_bit(p, OUTDT, offset, value);
> -=09spin_unlock_irqrestore(&p->lock, flags);
> +=09raw_spin_unlock_irqrestore(&p->lock, flags);
>  }
> =20
>  static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long=
 *mask,
> @@ -329,12 +329,12 @@ static void gpio_rcar_set_multiple(struct gpio_chip=
 *chip, unsigned long *mask,
>  =09if (!bankmask)
>  =09=09return;
> =20
> -=09spin_lock_irqsave(&p->lock, flags);
> +=09raw_spin_lock_irqsave(&p->lock, flags);
>  =09val =3D gpio_rcar_read(p, OUTDT);
>  =09val &=3D ~bankmask;
>  =09val |=3D (bankmask & bits[0]);
>  =09gpio_rcar_write(p, OUTDT, val);
> -=09spin_unlock_irqrestore(&p->lock, flags);
> +=09raw_spin_unlock_irqrestore(&p->lock, flags);
>  }
> =20
>  static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned o=
ffset,
> @@ -448,7 +448,7 @@ static int gpio_rcar_probe(struct platform_device *pd=
ev)
>  =09=09return -ENOMEM;
> =20
>  =09p->dev =3D dev;
> -=09spin_lock_init(&p->lock);
> +=09raw_spin_lock_init(&p->lock);
> =20
>  =09/* Get device configuration from DT node */
>  =09ret =3D gpio_rcar_parse_dt(p, &npins);
> --=20
> 2.43.0

