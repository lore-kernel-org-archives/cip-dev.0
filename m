Return-Path: <SRS0=Tvce=5O=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824E6C43331
	for <cip-dev@archiver.kernel.org>; Sun, 29 Mar 2020 10:58:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21297206DB
	for <cip-dev@archiver.kernel.org>; Sun, 29 Mar 2020 10:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21297206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C1F012044A;
	Sun, 29 Mar 2020 10:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WfphmvnGoit7; Sun, 29 Mar 2020 10:58:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BA1A220403;
	Sun, 29 Mar 2020 10:58:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CFD8C07FF;
	Sun, 29 Mar 2020 10:58:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBECAC07FF
 for <cip-dev@lists.cip-project.org>; Sun, 29 Mar 2020 10:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C06C72044A
 for <cip-dev@lists.cip-project.org>; Sun, 29 Mar 2020 10:57:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MC3JoVq0fT-a for <cip-dev@lists.cip-project.org>;
 Sun, 29 Mar 2020 10:57:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by silver.osuosl.org (Postfix) with ESMTPS id 07AE520403
 for <cip-dev@lists.cip-project.org>; Sun, 29 Mar 2020 10:57:57 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id ED7071C0323; Sun, 29 Mar 2020 12:57:52 +0200 (CEST)
Date: Sun, 29 Mar 2020 12:57:52 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, ben.hutchings@codethink.co.uk,
 cip-dev@lists.cip-project.org
Message-ID: <20200329105752.GA8804@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Subject: [cip-dev] 4.4-rt: Need testing on arm32
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0736732002087664028=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============0736732002087664028==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I tried to prepare next 4.4-rt release. I have code ready, but while
running tests I realized that only two targets are used to run them.

We 4.19-rt has known bugs breaking boot on de0-nano (and probably
other) boards, and according to code inspection, same bug is present
in 4.4-rt. Fix is not complex, but I'm not comfortable applying it
without _any_ testing.

If I'm right, 4.4-rt should be broken on socfpga boards (arm32) in
non-realtime configuration; it should panic on boot in cca 50% of
cases. Patch below should fix it.

Best regards,
								Pavel

commit 20124aef8572b764ffd90d836253153102c763c5
Author: Pavel Machek <pavel@ucw.cz>
Date:   Sat Mar 21 22:58:43 2020 +0100

    With -rt tree but prempt-rt not enabled, de0-nano was getting failures
    during boot, such as this:
   =20
    https://lava.ciplatform.org/scheduler/job/13037
   =20
    [    6.813352] Freeing unused kernel memory: 1024K
    [    6.817927] Unable to handle kernel paging request at virtual addres=
s e7fddef0
    [    6.825121] pgd =3D (ptrval)
    [    6.827816] [e7fddef0] *pgd=3D27e1141e(bad)
    [    6.831818] Internal error: Oops: 8000000d [#1] SMP ARM
    [    6.837019] Modules linked in:
    [    6.840067] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.106-cip21=
-gc82fe0af5 #1
    [    6.847601] Hardware name: Altera SOCFPGA
    [    6.851596] PC is at 0xe7fddef0
    [    6.854733] LR is at irq_work_run_list+0x84/0xc0
   =20
    Bisect revealed fc9f4631a290 is the problematic commit, and some code
    auditing revealed that it is working with wrong list. Fix it.
   =20
    Signed-off-by: Pavel Machek <pavel@denx.de>
    Fixes: fc9f4631a290 ("irqwork: push most work into softirq context")

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2899ba0d23d1..19896e6f1b2a 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -78,7 +78,8 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_I=
RQ))
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_=
IRQ))
+	    || (work->flags & IRQ_WORK_LAZY))
 		list =3D &per_cpu(lazy_list, cpu);
 	else
 		list =3D &per_cpu(raised_list, cpu);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXoB/MAAKCRAw5/Bqldv6
8rBZAKCUFxHGD4EVTGAsx+8G7A2wa/pAIgCeIynPBwFlzT3J4sV2TcqKuRAwLzk=
=fl7k
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

--===============0736732002087664028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============0736732002087664028==--
