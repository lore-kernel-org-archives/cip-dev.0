Return-Path: <SRS0=W4f2=4U=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F3BC3F2D1
	for <cip-dev@archiver.kernel.org>; Tue,  3 Mar 2020 17:10:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D49020728
	for <cip-dev@archiver.kernel.org>; Tue,  3 Mar 2020 17:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D49020728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 03B5185D95;
	Tue,  3 Mar 2020 17:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HCcKUQfjzSjX; Tue,  3 Mar 2020 17:10:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 00B3985D92;
	Tue,  3 Mar 2020 17:10:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECC49C013E;
	Tue,  3 Mar 2020 17:10:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73D22C013E
 for <cip-dev@lists.cip-project.org>; Tue,  3 Mar 2020 17:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6EEF286416
 for <cip-dev@lists.cip-project.org>; Tue,  3 Mar 2020 17:10:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5E2L-V8Bv95v for <cip-dev@lists.cip-project.org>;
 Tue,  3 Mar 2020 17:10:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7FC0D85045
 for <cip-dev@lists.cip-project.org>; Tue,  3 Mar 2020 17:10:53 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id C75291C0323; Tue,  3 Mar 2020 18:10:49 +0100 (CET)
Date: Tue, 3 Mar 2020 18:10:49 +0100
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Message-ID: <20200303171049.GB24044@duo.ucw.cz>
References: <20200303091556.GA10040@duo.ucw.cz>
 <20200303092343.GA11594@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20200303092343.GA11594@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] 4.19.106-cip21-rt8 problems on de0-nano
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
Content-Type: multipart/mixed; boundary="===============0734837337265684088=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============0734837337265684088==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I pushed candidate for -cip-rt, but it seems to fail on de0-nano
> > board. Code under testing is at:
> >=20
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux=
-cip
>=20
> It is pipeline
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/122762401
>=20
> I'll reuse the branch for more testing.

I managed to narrow the bad commit to the -rt tree, between:

OK 122904930 pick 69aa73357e6a rcu: Don't allow to change rcu_normal_after_=
boot on RT
pick 849ef8789077 pci/switchtec: fix stream_open.cocci warnings
pick ad8a5e8279c4 sched/core: Drop a preempt_disable_rt() statement
pick 966f066d96cb timers: Redo the notification of canceling timers on -RT
pick 0393fd5a4f9a Revert "futex: Ensure lock/unlock symetry versus pi_lock =
and hash bucket lock"
pick 84eb0b64a27a Revert "futex: Fix bug on when a requeued RT task times o=
ut"
pick fcc893280f4e Revert "rtmutex: Handle the various new futex race condit=
ions"
pick 2eac93cf9d16 Revert "futex: workaround migrate_disable/enable in diffe=
rent context"
pick 9b8964629f4f futex: Make the futex_hash_bucket lock raw
pick cc1812bf198b futex: Delay deallocation of pi_state
> pick f5e115c43100 mm/zswap: Do not disable preemption in zswap_frontswap_=
store()
pick e0d0d09a08ad revert-aio
pick a0a40bfb4300 fs/aio: simple simple work
pick 0fae581d8c5e revert-thermal
pick c0d95b4a8a1b thermal: Defer thermal wakups to threads
pick 700fbb4afb6e revert-block
pick 4cda50ff12cf block: blk-mq: move blk_queue_usage_counter_release() int=
o process context
pick 9e982f55745b workqueue: rework
pick c0db53dc3bf4 i2c: exynos5: Remove IRQF_ONESHOT
pick 1f160d170203 i2c: hix5hd2: Remove IRQF_ONESHOT
BAD 122882826 eae5a7cab722 sched/deadline: Ensure inactive_timer runs in ha=
rdirq context

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXl6PmQAKCRAw5/Bqldv6
8vheAKCNwo6PeHMDN8NjOpJi2A1EoWQWxACgspElDitWkydud7kYKYurhbZ24HI=
=+Qhq
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--

--===============0734837337265684088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============0734837337265684088==--
