Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E8FECAAA1
	for <webhook@archiver.kernel.org>; Thu, 27 Oct 2022 19:24:49 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1597.1666898684296625241
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Oct 2022 12:24:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2A4D01C09E0; Thu, 27 Oct 2022 21:24:41 +0200 (CEST)
Date: Thu, 27 Oct 2022 21:24:40 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <chris.paterson2@renesas.com>,
	cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: Still random failures at gitlab
Message-ID: <20221027192440.GA11819@duo.ucw.cz>
References: <20221020160844.GA19694@duo.ucw.cz>
 <TYCPR01MB10588638D4BFDFF15F7CB9E98B7319@TYCPR01MB10588.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB10588638D4BFDFF15F7CB9E98B7319@TYCPR01MB10588.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Oct 2022 19:24:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9881


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm still getting random failures at gitlab. Is the info below enough
/ can I retry the tests now to get real results?

Thanks and best regards,
									Pavel

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/6=
79070235

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/323899=
8916

Running with gitlab-runner 15.4.0 (43b2dc3d)
2  on 1665142213-cip-project-small-v9-project-gitlab-runner-85dctt8xr Uf_Ms=
YPS
3  feature flags: FF_KUBERNETES_HONOR_ENTRYPOINT:true
4
Resolving secrets
00:00
6
Preparing the "kubernetes" executor
00:00
7Using Kubernetes namespace: gitlab
8Using Kubernetes executor with image registry.gitlab.com/cip-project/cip-t=
esting/linux-cip-ci:test-v3 ...
9Using attach strategy to execute scripts...
11
Preparing environment
03:07
12Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
13	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
14Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
15	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
16Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
17	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
18Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
19	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
20Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
21	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
22Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
23	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
24Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
25	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
26Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
27	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
28Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
29	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
30Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
31	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
32Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
33	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
34Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
35	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
36Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
37	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
38Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
39	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
40Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
41	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
42Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-0nzck6 =
to be running, status is Pending
43	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated taint=
 {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are avail=
able: 1 Preemption is not helpful for scheduling."
44Waiting for pod gitlab/runner-ufmsyps-project



--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1ra+AAKCRAw5/Bqldv6
8iulAKC+jpkIYT7jjBRxiDbsVSX8qmnoPQCgilElRywA30Qua2xJddw+AHQmip8=
=8wjf
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

