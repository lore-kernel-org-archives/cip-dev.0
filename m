Return-Path: <SRS0=Ay0h=OF=lists.cip-project.org=bounce+64572+6736+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97E3C433FE
	for <cip-dev@archiver.kernel.org>; Wed, 15 Sep 2021 12:14:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5A861216
	for <cip-dev@archiver.kernel.org>; Wed, 15 Sep 2021 12:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D5A861216
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ohp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0jK8YY4521723xWygp0wKPVc; Wed, 15 Sep 2021 05:14:51 -0700
Subject: [cip-dev] Watchdog triggered do_futex() on 4.4.277-cip60-rt35 #cip
To: cip-dev@lists.cip-project.org
From: "Sebastian Holzgreve" <holzgreve@ohp.de>
X-Originating-Location: Rimbach, Hesse, DE (45.14.189.13)
X-Originating-Platform: Linux Chrome 93
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 15 Sep 2021 05:14:50 -0700
Message-ID: <9DmP.1631708090889080063.OWxj@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: HNcHi1EKhd7R877YF9lzdYuxx4520388AA=
Content-Type: multipart/mixed; boundary="LAajgpilfLN7y9H5X2Si"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631708091;
 bh=P40UwRpRPxziOkcWMAI0L5qcYrEHjVN1xVhXXiQA6FU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=cI5CQjiJAErFDEeXs+kS2KCsGVVstIIDqMcuAmR0o4jsB6sGJDA7pwuATDHQROwvYPm
 HDT5c7GEO22rQRPivKMJZoJbEA9JmH0acXsnHprMUuJn0jju4FaplVrznzkdPwUTHJ8ph
 GqgUgCffEL5Rjs2hXZ9HZtHB7P4AWXm7NmM=

--LAajgpilfLN7y9H5X2Si
Content-Type: multipart/alternative; boundary="DpqOY0gzGLkUP8O6VyTj"

--DpqOY0gzGLkUP8O6VyTj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

we were using the=C2=A04.4.277-cip60-rt35 kernel and it happens from time t=
o time that the kernel watchdog is triggered and our embedded devices gets =
resetted.

This message specially appers when we run the CodeSYS Runtime (PLC runtime)

>=20
> [=C2=A0 536.133081] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
> [BlkDrvUdp:330]
> [=C2=A0 536.140637] Modules linked in:
> [=C2=A0 536.143756] CPU: 0 PID: 330 Comm: BlkDrvUdp Not tainted
> 4.4.277-cip60-rt35-ohp+gd23c00f1c39e #1
> [=C2=A0 536.152489] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device T=
ree)
> [=C2=A0 536.158967] task: 86bd7700 ti: 841aa000 task.ti: 841aa000
> [=C2=A0 536.164408] PC is at do_futex+0x458/0xa98
> [=C2=A0 536.168450] LR is at do_futex+0x428/0xa98
> [=C2=A0 536.172487] pc : [<80069a40>]=C2=A0 =C2=A0 lr : [<80069a10>]=C2=
=A0 =C2=A0 psr: a0070013
> [=C2=A0 536.172487] sp : 841abe90=C2=A0 ip : 86896244=C2=A0 fp : 841abf4c
>=20

I contacted the support and they told me following about usage of mutexes o=
f the runtime:

The runtime is using pi mutexes
>=20
> pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);

and also with recursive attribute.

>=20
> pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE_NP);

and that they got other customers that had also problems with this constell=
ation.

My current knowledge of the linux kernel is not big enough to solve that pr=
oblem by myself. But i'm willed to learn more about the kernel and maybe so=
lve the problem by own.

Can anyone give me a hint how to continue investigation of that problem?
Maybe someone has solved that problem for another target hardware?

Every RTFM hint is also welcome, when it least tell me the manual to dig tr=
ough :)

Kind regards,
Sebastian

--DpqOY0gzGLkUP8O6VyTj
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,<br /><br />we were using the&nbsp;4.4.277-cip60-rt35 kernel and it happ=
ens from time to time that the kernel watchdog is triggered and our embedde=
d devices gets resetted.<br /><br />This message specially appers when we r=
un the CodeSYS Runtime (PLC runtime)<br /><br />
<blockquote>
<div style=3D"line-height: 1.42857;">[&nbsp; 536.133081] NMI watchdog: BUG:=
 soft lockup - CPU#0 stuck for 23s! [BlkDrvUdp:330]</div>
<div style=3D"line-height: 1.42857;">[&nbsp; 536.140637] Modules linked in:=
</div>
<div style=3D"line-height: 1.42857;">[&nbsp; 536.143756] CPU: 0 PID: 330 Co=
mm: BlkDrvUdp Not tainted 4.4.277-cip60-rt35-ohp+gd23c00f1c39e #1</div>
<div style=3D"line-height: 1.42857;">[&nbsp; 536.152489] Hardware name: Fre=
escale Vybrid VF5xx/VF6xx (Device Tree)</div>
<div style=3D"line-height: 1.42857;">[&nbsp; 536.158967] task: 86bd7700 ti:=
 841aa000 task.ti: 841aa000</div>
<div style=3D"line-height: 1.42857;">[&nbsp; 536.164408] PC is at do_futex+=
0x458/0xa98</div>
<div style=3D"line-height: 1.42857;">[&nbsp; 536.168450] LR is at do_futex+=
0x428/0xa98</div>
<div style=3D"line-height: 1.42857;">[&nbsp; 536.172487] pc : [&lt;80069a40=
&gt;]&nbsp; &nbsp; lr : [&lt;80069a10&gt;]&nbsp; &nbsp; psr: a0070013</div>
<div style=3D"line-height: 1.42857;">[&nbsp; 536.172487] sp : 841abe90&nbsp=
; ip : 86896244&nbsp; fp : 841abf4c</div>
</blockquote>
<br />I contacted the support and they told me following about usage of mut=
exes of the runtime:<br /><br />The runtime is using pi mutexes
<blockquote>pthread_mutexattr_setprotocol(&amp;attr, PTHREAD_PRIO_INHERIT);=
</blockquote>
and also with recursive attribute.<br />
<blockquote>pthread_mutexattr_settype(&amp;attr, PTHREAD_MUTEX_RECURSIVE_NP=
);</blockquote>
and that they got other customers that had also problems with this constell=
ation.<br /><br /><br />My current knowledge of the linux kernel is not big=
 enough to solve that problem by myself. But i'm willed to learn more about=
 the kernel and maybe solve the problem by own.<br /><br /><br />Can anyone=
 give me a hint how to continue investigation of that problem?<br />Maybe s=
omeone has solved that problem for another target hardware?<br /><br />Ever=
y RTFM hint is also welcome, when it least tell me the manual to dig trough=
 :)<br /><br />Kind regards,<br />Sebastian<br />

--DpqOY0gzGLkUP8O6VyTj--

--LAajgpilfLN7y9H5X2Si
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6736): https://lists.cip-project.org/g/cip-dev/message/=
6736
Mute This Topic: https://lists.cip-project.org/mt/85625711/4520388
Mute #cip:https://lists.cip-project.org/g/cip-dev/mutehashtag/cip
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--LAajgpilfLN7y9H5X2Si--
