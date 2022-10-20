Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00025C433FE
	for <webhook@archiver.kernel.org>; Thu, 20 Oct 2022 07:58:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.7045.1666252683890196648
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Oct 2022 00:58:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1C4701C09D6; Thu, 20 Oct 2022 09:58:01 +0200 (CEST)
Date: Thu, 20 Oct 2022 09:58:00 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20221020075759.GA17249@amd>
References: <CAODzB9q+zmEqdu1=u7JESKbqgDvkAjXaeRPXELRm7Gyg+-76FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <CAODzB9q+zmEqdu1=u7JESKbqgDvkAjXaeRPXELRm7Gyg+-76FA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Oct 2022 07:58:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9795


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CVE-2022-3523: mm/memory.c: fix race when faulting a device private page
>=20
> CVSS v3 score is not provided(NIST).
> CVSS v3 score is 5.3 MEDIUM(VulDB).
>=20
> A vulnerability was found in Linux Kernel. It has been classified as
> problematic. Affected is an unknown function of the file mm/memory.c
> of the component Driver Handler. The manipulation leads to use after
> free.
=2E..
> This fix is based on Memory folios feature so that it cannot apply to
> older kernels straightly.

Sounds like fun, but changelog also says:

    During normal usage it is unlikely these will cause any problems.
    However
        without these fixes it is possible to crash the kernel from
    userspace.
        These crashes can be triggered either by unloading the kernel
    module or
        unbinding the device from the driver prior to a userspace task
    exiting.

Yeah, so.. don't let untrusted users play with modules / device
bindings. We don't do that by default.

> CVE-2022-3524: tcp/udp: Fix memory leak in ipv6_renew_options().
>=20
> A vulnerability was found in Linux Kernel. It has been declared as
> problematic. Affected by this vulnerability is the function
> ipv6_renew_options of the component IPv6 Handler. The manipulation
> leads to memory leak. The attack can be launched remotely.
>=20
> CVSS v3 score is 7.5 HIGH(NIST).
> CVSS v3 score is 4.3 MEDIUM(VulDB).
>=20
> Kernel 4.4 is also affected by this issue. applying this fix needs to
> modify the patch.
>=20
> Fixed status
> mainline: [3c52c6bb831f6335c176a0fc7214e26f43adbd11]

Sounds like more fun.

> CVE-2022-3535: net: mvpp2: fix mvpp2 debugfs leak
>=20
> CVSS v3 score is not provided(NIST).
> CVSS v3 score is 3.5 LOW(VulDB).
>=20
> A vulnerability classified as problematic was found in Linux Kernel.
> Affected by this vulnerability is the function mvpp2_dbgfs_port_init
> of the file drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c of the
> component mvpp2. The manipulation leads to memory leak.
>=20
> Introduced by commit 21da57a ("net: mvpp2: add a debugfs interface for
> the Header Parser") in 4.19-rc1.
> 4.4, 4.9, 4.10, and 4.19 kernels are not affected by this issue.

4.19-rc1 means that 4.19 is affected, and indeed that commit is in
4.19-stable. Due to severity of the vulnerability (very low), I don't
think we care much.

> CVE-2022-3565: mISDN: fix use-after-free bugs in l1oip timer handlers
>=20
> CVSS v3 score is not provided(NIST).
> CVSS v3 score is 4.6 MEDIUM(VulDB).
>=20
> A vulnerability, which was classified as critical, has been found in
> Linux Kernel. Affected by this issue is the function del_timer of the
> file drivers/isdn/mISDN/l1oip_core.c of the component Bluetooth. The
> manipulation leads to use after free.

"Critial" -- really? mISDN does not have much to do with bluetooth. i
don't think we care.

> CVE-2022-3566: tcp: Fix data races around icsk->icsk_af_ops.
>=20
> CVSS v3 score is not provided(NIST).
> CVSS v3 score is 4.6 MEDIUM(VulDB).
>=20
> A vulnerability, which was classified as problematic, was found in
> Linux Kernel. This affects the function tcp_getsockopt/tcp_setsockopt
> of the component TCP Handler. The manipulation leads to race
> conditions.

There's no race in the compile code assuming sane compiler; this is
just READ_ONCE() annotation for the tools.

I wonder if we should simply ignore anything that is "medium" or
lower? This is not too useful. There are _lot_ of READ_ONCE
annotations:

rc-v5.10.132.list:a just a READ_ONCE annotation |dd36fc0e5 1f1be0 o: 5.10| =
sysctl: Fix data races in proc_dointvec().
rc-v5.10.132.list:a just a READ_ONCE annotation |3c353ca70 4762b5 o: 5.10| =
sysctl: Fix data races in proc_douintvec().
rc-v5.10.132.list:a just a READ_ONCE annotation |2d706aadb f613d8 o: 5.10| =
sysctl: Fix data races in proc_dointvec_minmax().
rc-v5.10.132.list:a just a READ_ONCE annotation |23f9db9f8 2d3b55 o: 5.10| =
sysctl: Fix data races in proc_douintvec_minmax().
rc-v5.10.132.list:a just a READ_ONCE annotation |3b18d2877 c31bcc o: 5.10| =
sysctl: Fix data races in proc_doulongvec_minmax().
rc-v5.10.132.list:a just a READ_ONCE annotation |fbb481c6c e87782 o: 5.10| =
sysctl: Fix data races in proc_dointvec_jiffies().
rc-v5.10.132.list:a just a READ_ONCE annotation |569565b31 47e6ab o: 5.10| =
tcp: Fix a data-race around sysctl_tcp_max_orphans.
rc-v5.10.132.list:a just a READ_ONCE annotation |1ffd2f3ca 3d32ed o: 4.19| =
inetpeer: Fix data-races around sysctl.
rc-v5.10.132.list:a just a READ_ONCE annotation |759957e29 310731 o: 4.19| =
net: Fix data-races around sysctl_mem.
rc-v5.10.132.list:a not a minimum fix, just a READ_ONCE annotation |2afb079=
f1 dd44f0 o: 4.9| cipso: Fix data-races around sysctl.
rc-v5.10.132.list:a just a READ_ONCE annotation |cc7dc7f73 48d7ee o: 4.9| i=
cmp: Fix data-races around sysctl.
rc-v5.10.132.list:a just a READ_ONCE annotation |ecc3b5b6d 73318c o: 5.10| =
ipv4: Fix a data-race around sysctl_fib_sync_mem.
rc-v5.10.132.list:a just a READ_ONCE annotation |8c0062e3d 2a4eb7 o: 4.19| =
icmp: Fix a data-race around sysctl_icmp_ratelimit.
rc-v5.10.132.list:a just a READ_ONCE annotation |abf7c1c68 1ebcb2 o: 4.19| =
icmp: Fix a data-race around sysctl_icmp_ratemask.
rc-v5.10.132.list:a not a minimum fix, just a READ_ONCE annotation |66a01e6=
57 e49e4a o: 4.9| ipv4: Fix data-races around sysctl_ip_dynaddr.
rc-v5.10.132.list:a just a READ_ONCE annotation |a9f8eb955 bdf00b o: 5.10| =
nexthop: Fix data-races around nexthop_compat_mode.
rc-v5.10.137.list:a just a READ_ONCE annotation |6a5c5b381 4915d5 o: 5.10| =
inet: add READ_ONCE(sk->sk_bound_dev_if) in INET_MATCH()
rc-v5.10.137.list:a just a READ_ONCE annotation, not a minimum fix |8d69424=
fb 5d368f o: 5.10| ipv6: add READ_ONCE(sk->sk_bound_dev_if) in INET6_MATCH()
rc-v5.10.137.list:a just a READ_ONCE annotation |1651eed8e 08a75f o: 5.10| =
tcp: Fix data-races around sysctl_tcp_l3mdev_accept.
rc-v5.10.140.list:a just a READ_ONCE annotation |1cf035989 027395 o: 5.10| =
net: Fix data-races around sysctl_[rw]mem(_offset)?.
rc-v5.10.140.list:a just a READ_ONCE annotation |c430cce0f 1227c1 o: 5.10| =
net: Fix data-races around sysctl_[rw]mem_(max|default).
rc-v5.10.140.list:a just a READ_ONCE annotation |0ca09591c 5dcd08 o: 5.10| =
net: Fix data-races around netdev_max_backlog.
rc-v5.10.140.list:a just a READ_ONCE annotation |c9a25e523 61adf4 o: 4.19| =
net: Fix data-races around netdev_tstamp_prequeue.
rc-v5.10.140.list:a just a READ_ONCE annotation |33a56c470 7de6d0 o: 5.10| =
net: Fix data-races around sysctl_optmem_max.
rc-v5.10.140.list:a just a READ_ONCE annotation |b88a8545b d2154b o: 4.9| n=
et: Fix a data-race around sysctl_tstamp_allow_data.
rc-v5.10.140.list:a just a READ_ONCE annotation |ff5a88e37 c42b7c o: 4.9| n=
et: Fix a data-race around sysctl_net_busy_poll.
rc-v5.10.140.list:a just a READ_ONCE annotation |b99764a7c e59ef3 o: 4.9| n=
et: Fix a data-race around sysctl_net_busy_read.
rc-v5.10.140.list:a just a READ_ONCE annotation |6d73091c1 fa45d4 o: 4.19| =
net: Fix a data-race around netdev_budget_usecs.
rc-v5.10.140.list:a just a READ_ONCE annotation |99e03c89b 3c9ba8 o: 4.9| n=
et: Fix a data-race around sysctl_somaxconn.
rc-v5.10.140-sep7.list:a just a READ_ONCE annotation |b88a8545b d2154b o: 4=
=2E9| net: Fix a data-race around sysctl_tstamp_allow_data.
rc-v5.10.140-sep7.list:a just a READ_ONCE annotation |ff5a88e37 c42b7c o: 4=
=2E9| net: Fix a data-race around sysctl_net_busy_poll.
rc-v5.10.140-sep7.list:a just a READ_ONCE annotation |b99764a7c e59ef3 o: 4=
=2E9| net: Fix a data-race around sysctl_net_busy_read.
rc-v5.10.140-sep7.list:a just a READ_ONCE annotation |99e03c89b 3c9ba8 o: 4=
=2E9| net: Fix a data-race around sysctl_somaxconn.
rc-v5.10.14X-pre.list:a just a READ_ONCE annotation 5.10 05/16] cgroup: Rem=
ove data-race around cgrp_dfl_visible
rc-v5.10.150.list:a just a READ_ONCE annotation |1b3ae95b2 aacd46 o: 4.9| t=
cp: annotate data-race around tcp_md5sig_pool_populated

> CVE-2022-3567: ipv6: Fix data races around sk->sk_prot.
>=20
> CVSS v3 score is not provided(NIST).
> CVSS v3 score is 4.6 MEDIUM(VulDB).
>=20
> A vulnerability has been found in Linux Kernel and classified as
> problematic. This vulnerability affects the function
> inet6_stream_ops/inet6_dgram_ops of the component IPv6 Handler. The
> manipulation leads to race conditions.
>=20
> According to the commit log, commit 086d490 ("ipv6: annotate some
> data-races around sk->sk_prot") fixes a race condition bug but it was
> not enough.
> Therefore it seems that both commit 086d490 and 364f997 need to fix
> this issue.

This is a tiny bit more serious than usual READ_ONCE annotations,
but...

> CVE-2022-3541: eth: sp7021: fix use after free bug in
> spl2sw_nvmem_get_mac_address
>=20
> CVSS v3 score is 7.8 HIGH(NIST).
> CVSS v3 score is 5.5 MEDIUM(VulDB).
>=20
> A vulnerability classified as critical has been found in Linux Kernel.
> This affects the function spl2sw_nvmem_get_mac_address of the file
> drivers/net/ethernet/sunplus/spl2sw_driver.c of the component BPF. The
> manipulation leads to use after free.

Component BPF?

> CVE-2022-3594: r8152: Rate limit overflow messages
>=20
> CVSS v3 score is not provided(NIST).
> CVSS v3 score is 5.3 MEDIUM(VulDB).
>=20
> A vulnerability was found in Linux Kernel. It has been declared as
> problematic. Affected by this vulnerability is the function
> intr_callback of the file drivers/net/usb/r8152.c of the component
> BPF. The manipulation leads to logging of excessive data. The attack
> can be launched remotely.
>=20
> Fixed status
> mainline: [93e2be344a7db169b7119de21ac1bf253b8c6907]

The "attack" is writing line to syslog. Seems like every bug can get a
CVE if someone tries.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmNQ/4cACgkQMOfwapXb+vK7VACgpUfpFEKR5UDE94M7nFsJuwOc
z9oAnA5th7RqB4jUWTHJ2wVX3VRgnvBR
=Jtwu
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

