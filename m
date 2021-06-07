Return-Path: <SRS0=aBcM=LB=lists.cip-project.org=bounce+64572+6495+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520FEC47082
	for <cip-dev@archiver.kernel.org>; Mon,  7 Jun 2021 05:23:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A327E610FB
	for <cip-dev@archiver.kernel.org>; Mon,  7 Jun 2021 05:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A327E610FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=abwesend.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6495+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0uVaYY4521723xuORgSWLKA0; Sun, 06 Jun 2021 22:23:42 -0700
X-Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by mx.groups.io with SMTP id smtpd.web09.32141.1623043420581926600
 for <cip-dev@lists.cip-project.org>;
 Sun, 06 Jun 2021 22:23:41 -0700
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
X-Received: from [178.190.128.91] ([178.190.128.91]) by web-mail.gmx.net
 (3c-app-gmx-bap15.server.lan [172.19.172.85]) (via HTTP); Mon, 7 Jun 2021
 07:23:38 +0200
MIME-Version: 1.0
Message-ID: <trinity-17b11b5f-9805-4527-89fb-1f3a0103a164-1623043418611@3c-app-gmx-bap15>
From: "Rainer Kloud" <rainer.kloud@abwesend.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] BUG: using smp_processor_id() in preemptible [00000000] code: TCPTSK/1809
Date: Mon, 7 Jun 2021 07:23:38 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210606191433.GA18130@amd>
References: <trinity-6c08d14f-96d0-4b01-b81c-dbc85783818e-1622901051584@3c-app-gmx-bs72>
 <20210606191433.GA18130@amd>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ZGxh3xhYN6p/addhWEFDHlOr6uZOSYx5LX4AhzhHmr+wLw4fwNm1KZwbZPCI4lmacBfTm
 UD4ZEFT/xCFGIiTSoFQDEHEq/QFnf1q8HLl1wwDgC9Tnmrct73noQVhwRWi3gxpTeb+z+Zr6uOXE
 RgDqksNzcUIdjcNvJBqUhZ1k9w0GjOb1h2nLyQWCfqmyWCMMEY97f+kEExZInUlLoazIRsNHuEzU
 g315QDaxXh8b0DHGEbF08SUPJUKvfJAfel5wREuHbI/UyPdTGF9Hbb2Q2YDTTk0uWlf/gV9afk1g
 lk=
X-UI-Out-Filterresults: notjunk:1;V03:K0:K37hYmTUPc0=:cbnVUQiKgJRIc5mHixaXXY
 7svcjAN0eyHCjcUKCwHhqPUV4C9iDTiYTSzQmOm8LA+EpY4xAOVlab6AGDBv0oZfEe1RPfl58
 mtE5itYKNuRSZl8/Jbq56dc/nHTHJhnZ9LJh9iwR21LJpew/p5B6A4NXO3ew9ySuDRShdXfnj
 H0G1UyATaYod3xdjUP7Za+guXdhMCtsHlLaDp9VnR0ghlsGWSFVh2LWsMGzGE8SqadG7Bhug8
 tdKLLGwhd07YF9BpaoCN27w/nxiy9NpNmNhEfP5aMo/Va1047HHyy0DflllswZ4cNkLS2XaiO
 0HOcPZxiacJtv2T3SehBXaCYlas/Wq+EmJF0/6pa3zUjtYZ1v/aqSX2drq0qpFOh7JX+bd5Q7
 XFwuyFWlEiEEonx2Arn5+kL/QoEfRjUCkhztmBBMHmIv0FdQdAdQxm+6vsFo5/Iqpm5LIm31H
 cvQJ2GSQdHAwBltGXKFS4SpMpKocm7W/D3eOlWfTkBKUT+yg0/PrphJfTgwH271xTY6nPCIe0
 JWS8mIQr9fjwRNpf/wKne0D1YFp/9jtgJu9Nv9I75XDs3d3jMgsayOwMSLiSYTk706CcUA0Pq
 wnHf9cqGmJofckQV4PGkOKOjU0ukUF37biHnEstg6u7A/pHhelp5Ww18tANiqAt07UiY9o6vZ
 cIUO/20X9+glNyWHaGkFSyH9Ct8xtfp5NBcPibRUFCYOc9/t6IbBNSLmtbmacHJvgC5EM9rUz
 C+/qhEOtedlW7FyD1Q3beDytkFtx0vL/C271pUqiK43Ek0cpsYj0pmWJK+GSMFecx5Fnvv8In
 Ey1O+13pinML7YsCRwDphjlQ9G8R2Zt1jUizKk1467MrnoIGf4=
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EOlceMrWsJMR0OrWlbKxlMIfx4520388AA=
Content-Type: multipart/mixed; boundary="E3NHphJHaMGcC106inwD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623043422;
 bh=oD6dAIxRBL+nr7vl2uEC18kP/2I3lwGc1kMRIaKIzJU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ROVHqpHkGg585e37ZVm1iRhrmKq6Lr+8zXXDTHUrf7ME11mLahn8QtfRi9RXz9E2fPo
 uiNnthfBrvQRIxNEs6PdTa7w8u47N0SDsMoM1bYmDn1CHw7xR+BCINacoFo260vsyd3si
 Qzk5Ui9WHHbr+awlHEBkWKLnwSJG6iOMKZM=

--E3NHphJHaMGcC106inwD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> I notice you are using -rt kernel. Do you actually need realtime
> features?

Yes, I actually need the realtime feature. I have one task which
needs to run periodically in realtime (triggered every 10ms by an
external IRQ).

> Can you try to reproduce the problem on 4.19.193?

This is only a problem with the realtime patch. The patch
introduces migrate_enable which is part of the callstack:

Jun 1 09:11:46 sicam kernel: [46802.944165] BUG: using smp_processor_id() =
in preemptible [00000000] code: TCPTSK/1809
Jun 1 09:11:46 sicam kernel: [46802.944210] caller is migrate_enable+0x40/=
0x488
Jun 1 09:11:46 sicam kernel: [46802.944221] CPU: 0 PID: 1809 Comm: TI4SDTS=
K#135 Tainted: G W 4.19.165-cip41-rt18 #1
Jun 1 09:11:46 sicam kernel: [46802.944225] Hardware name: Altera SOCFPGA
Jun 1 09:11:46 sicam kernel: [46802.944252] [<c010e9d4>] (unwind_backtrace=
) from [<c010b9f4>] (show_stack+0x10/0x14)
Jun 1 09:11:46 sicam kernel: [46802.944272] [<c010b9f4>] (show_stack) from=
 [<c062f854>] (dump_stack+0x94/0xa8)
Jun 1 09:11:46 sicam kernel: [46802.944299] [<c062f854>] (dump_stack) from=
 [<c03a57ec>] (check_preemption_disabled+0x110/0x114)
Jun 1 09:11:46 sicam kernel: [46802.944316] [<c03a57ec>] (check_preemption=
_disabled) from [<c014163c>] (migrate_enable+0x40/0x488)
Jun 1 09:11:46 sicam kernel: [46802.944338] [<c014163c>] (migrate_enable) =
from [<c053ff0c>] (ip_finish_output2+0x21c/0x460)
Jun 1 09:11:46 sicam kernel: [46802.944353] [<c053ff0c>] (ip_finish_output=
2) from [<c0542854>] (ip_output+0x140/0x184)
Jun 1 09:11:46 sicam kernel: [46802.944364] [<c0542854>] (ip_output) from =
[<c0542128>] (__ip_queue_xmit+0x134/0x40c)
Jun 1 09:11:46 sicam kernel: [46802.944381] [<c0542128>] (__ip_queue_xmit)=
 from [<c055cf70>] (__tcp_transmit_skb+0x53c/0xb20)
Jun 1 09:11:46 sicam kernel: [46802.944392] [<c055cf70>] (__tcp_transmit_s=
kb) from [<c055e188>] (tcp_write_xmit+0x27c/0xfd0)
Jun 1 09:11:46 sicam kernel: [46802.944403] [<c055e188>] (tcp_write_xmit) =
from [<c055ef10>] (__tcp_push_pending_frames+0x34/0xa8)
Jun 1 09:11:46 sicam kernel: [46802.944413] [<c055ef10>] (__tcp_push_pendi=
ng_frames) from [<c054f5cc>] (tcp_sendmsg_locked+0x66c/0xc40)
Jun 1 09:11:46 sicam kernel: [46802.944422] [<c054f5cc>] (tcp_sendmsg_lock=
ed) from [<c054fbc8>] (tcp_sendmsg+0x28/0x3c)
Jun 1 09:11:46 sicam kernel: [46802.944441] [<c054fbc8>] (tcp_sendmsg) fro=
m [<c04cb3f4>] (sock_sendmsg+0x14/0x24)
Jun 1 09:11:46 sicam kernel: [46802.944455] [<c04cb3f4>] (sock_sendmsg) fr=
om [<c04cc6d0>] (__sys_sendto+0xc4/0x104)
Jun 1 09:11:46 sicam kernel: [46802.944467] [<c04cc6d0>] (__sys_sendto) fr=
om [<c04cc72c>] (sys_send+0x18/0x20)
Jun 1 09:11:46 sicam kernel: [46802.944479] [<c04cc72c>] (sys_send) from [=
<c0101000>] (ret_fast_syscall+0x0/0x5c)
Jun 1 09:11:46 sicam kernel: [46802.944484] Exception stack(0xda337fa8 to =
0xda337ff0)
Jun 1 09:11:46 sicam kernel: [46802.944493] 7fa0: 001c6f2c 00000001 000000=
37 0020ae40 00000006 00000000
Jun 1 09:11:46 sicam kernel: [46802.944502] 7fc0: 001c6f2c 00000001 000000=
01 00000121 001651c8 001ea378 ffff0000 00000006
Jun 1 09:11:46 sicam kernel: [46802.944508] 7fe0: 00000000 b3efea18 000000=
00 b6a2ff40

Best Regards,
Rainer

--E3NHphJHaMGcC106inwD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6495): https://lists.cip-project.org/g/cip-dev/message=
/6495
Mute This Topic: https://lists.cip-project.org/mt/83330337/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--E3NHphJHaMGcC106inwD--
