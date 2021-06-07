Return-Path: <SRS0=vamQ=LB=lists.cip-project.org=bounce+64572+6498+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BC1C47082
	for <cip-dev@archiver.kernel.org>; Mon,  7 Jun 2021 11:45:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D239F6105A
	for <cip-dev@archiver.kernel.org>; Mon,  7 Jun 2021 11:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D239F6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.at
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6498+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IHvcYY4521723xVfChm7JXON; Mon, 07 Jun 2021 04:45:10 -0700
X-Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by mx.groups.io with SMTP id smtpd.web11.31864.1623040297143356681
 for <cip-dev@lists.cip-project.org>;
 Sun, 06 Jun 2021 21:31:37 -0700
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
X-Received: from [178.190.128.91] ([178.190.128.91]) by web-mail.gmx.net
 (3c-app-gmx-bap15.server.lan [172.19.172.85]) (via HTTP); Mon, 7 Jun 2021
 06:31:35 +0200
MIME-Version: 1.0
Message-ID: <trinity-5cb5bf59-3064-486c-8493-646cb4fbf0e1-1623040295084@3c-app-gmx-bap15>
From: rainer.kloud@gmx.at
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] BUG: using smp_processor_id() in preemptible [00000000] code: TCPTSK/1809
Date: Mon, 7 Jun 2021 06:31:35 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210606191433.GA18130@amd>
References: <trinity-6c08d14f-96d0-4b01-b81c-dbc85783818e-1622901051584@3c-app-gmx-bs72>
 <20210606191433.GA18130@amd>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:IeZ1ucSceFvr5z1hsrYiTR18nBToKO7jYDBLrvw7M6skFPdeWWVXhs4BFHZ9Krzk6Scqf
 r8TvRl7hdooySW2zP5YQFbyIyy2fXo85PZMT8mW1/iSD2cP7tpZNWsd3UOpildtYyQZ9eSn31qf5
 uB/UbNTWsS1xYSXV9dwF4MNZLHfv4JVBzzQySZdwCbvBdpEQOYhmRKQuAYpNWMZSVBoNcHyDD3Hx
 RpihSQellkiE/YRRKxx/d7dQUtDKvDK663mIuO+v0L2ZBceceVcinLydcAIlR06ufRHm289sUz5k
 K8=
X-UI-Out-Filterresults: notjunk:1;V03:K0:fvGOKMDLGnU=:dlMtUHeLqMyaVZ8eFGIPZQ
 i2RW9QzycfROspgvk0WaWEMIS5n4673FojYD9NZbmv/h1dZPm93i8FPp59rOG0p9jw/262Lc4
 01HTEtB/OWWPzeOjOFzn/q9a5NBpE44c5Con6pe1goJ1/owdOVzVsViMXqMmhUqOIqj/avzZa
 aIDmyvO7IGJpBx9Y/oRWd5wKb491WZEM7u60FAyf03VQSWMmH6J9SozWBb4dYfeSiWxpSyb63
 T2XuYySs287hiNwv7XiNEeWj2WkhnZO/dFR92hSjpMufZotITZgzBqBMORisWyJUcTi99LaFB
 7eKD3PUvvyZ5cKXmWmv2VbZJetpqQlCiOlkJSPDTu0AxLEaUEDOYjQfuWq/NqwQ+Q+RMpKucT
 f9zT/VhwAkkDZNaN29WJ+paEyU8YyCJridRJWFbttp4PoPvztE/WmoDvgJBspf9MY8UqtmYii
 JWesRt4VnZ8ZDoPM8UigQImrjEn8kE58umv2P8+U1cX8XbR66qxjI4+d09VQ6bJXVQ1xyZy3r
 GHCv26H+E6OOnT7KjPqmpy4Fx1fakvD8h2HC4YuDR2Gr06aT0K6YA8VynAl331Iy1W4+veBt1
 WglJpgiPcurInTbLQXV3eSKRjcDS5VOXJNPrimrJdey4lRRAZxlJSg2TnaKcDg6Ppl8gvacFK
 j6My/OQ7a+9KB+CTCoAkHS8fVlsjmhmgkM/JGOphdEeU7f25ObeOkFa3r1vx+QNh6HQefkZX9
 2AZlTgE+G4CzxbLlLwynMzUDKvs6GGwjD4Q4FYVZGM8B7pl0XCg7qsH3QqQ19udjlVyTmlt+S
 sSa96oyHExzcYtRouZjp6ls9l+CjA==
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dT1kdrgRPeP4t7giuHsfV0bQx4520388AA=
Content-Type: multipart/mixed; boundary="skSlsODNy64ESaANZ9xD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623066310;
 bh=xweHeOLg2hm8IdMsFPFSwHZvOozro7yrcF9i8KLvwLw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=w8XfSrmycy7GnVgDN0cRtZS4n4T0wAyrtWkDzkiRwgXNpQhcx+EH2juUiyOzE/ov99q
 fHPo/fL5dcQEMvcc+qWuPWEZkatDxjZ62Ru9llyMRHtx1XWAm604Q2B4ccB2i9LTU84Ik
 9V5gRFEDetYuSyuaYKl1cvVQ/MHTpsuh7ek=

--skSlsODNy64ESaANZ9xD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Pavel,
=C2=A0
> I notice you are using -rt kernel=2E Do you actually need realtime
> features?

Yes, I actually need the realtime feature=2E I have one task which
needts to run periodically in realtime (every 10ms)=2E

> Can you try to reproduce the problem on 4=2E19=2E193?

This is only a problem with the realtime patch=2E The patch
introduces migrate_enable which is part of the callstack:

Jun  1 09:11:46 sicam kernel: [46802=2E944165] BUG: using smp_processor_id=
() in preemptible [00000000] code: TCPTSK/1809
Jun  1 09:11:46 sicam kernel: [46802=2E944210] caller is migrate_enable+0x=
40/0x488
Jun  1 09:11:46 sicam kernel: [46802=2E944221] CPU: 0 PID: 1809 Comm: TI4S=
DTSK#135 Tainted: G        W         4=2E19=2E165-cip41-rt18 #1
Jun  1 09:11:46 sicam kernel: [46802=2E944225] Hardware name: Altera SOCFP=
GA
Jun  1 09:11:46 sicam kernel: [46802=2E944252] [<c010e9d4>] (unwind_backtr=
ace) from [<c010b9f4>] (show_stack+0x10/0x14)
Jun  1 09:11:46 sicam kernel: [46802=2E944272] [<c010b9f4>] (show_stack) f=
rom [<c062f854>] (dump_stack+0x94/0xa8)
Jun  1 09:11:46 sicam kernel: [46802=2E944299] [<c062f854>] (dump_stack) f=
rom [<c03a57ec>] (check_preemption_disabled+0x110/0x114)
Jun  1 09:11:46 sicam kernel: [46802=2E944316] [<c03a57ec>] (check_preempt=
ion_disabled) from [<c014163c>] (migrate_enable+0x40/0x488)
Jun  1 09:11:46 sicam kernel: [46802=2E944338] [<c014163c>] (migrate_enabl=
e) from [<c053ff0c>] (ip_finish_output2+0x21c/0x460)
Jun  1 09:11:46 sicam kernel: [46802=2E944353] [<c053ff0c>] (ip_finish_out=
put2) from [<c0542854>] (ip_output+0x140/0x184)
Jun  1 09:11:46 sicam kernel: [46802=2E944364] [<c0542854>] (ip_output) fr=
om [<c0542128>] (__ip_queue_xmit+0x134/0x40c)
Jun  1 09:11:46 sicam kernel: [46802=2E944381] [<c0542128>] (__ip_queue_xm=
it) from [<c055cf70>] (__tcp_transmit_skb+0x53c/0xb20)
Jun  1 09:11:46 sicam kernel: [46802=2E944392] [<c055cf70>] (__tcp_transmi=
t_skb) from [<c055e188>] (tcp_write_xmit+0x27c/0xfd0)
Jun  1 09:11:46 sicam kernel: [46802=2E944403] [<c055e188>] (tcp_write_xmi=
t) from [<c055ef10>] (__tcp_push_pending_frames+0x34/0xa8)
Jun  1 09:11:46 sicam kernel: [46802=2E944413] [<c055ef10>] (__tcp_push_pe=
nding_frames) from [<c054f5cc>] (tcp_sendmsg_locked+0x66c/0xc40)
Jun  1 09:11:46 sicam kernel: [46802=2E944422] [<c054f5cc>] (tcp_sendmsg_l=
ocked) from [<c054fbc8>] (tcp_sendmsg+0x28/0x3c)
Jun  1 09:11:46 sicam kernel: [46802=2E944441] [<c054fbc8>] (tcp_sendmsg) =
from [<c04cb3f4>] (sock_sendmsg+0x14/0x24)
Jun  1 09:11:46 sicam kernel: [46802=2E944455] [<c04cb3f4>] (sock_sendmsg)=
 from [<c04cc6d0>] (__sys_sendto+0xc4/0x104)
Jun  1 09:11:46 sicam kernel: [46802=2E944467] [<c04cc6d0>] (__sys_sendto)=
 from [<c04cc72c>] (sys_send+0x18/0x20)
Jun  1 09:11:46 sicam kernel: [46802=2E944479] [<c04cc72c>] (sys_send) fro=
m [<c0101000>] (ret_fast_syscall+0x0/0x5c)
Jun  1 09:11:46 sicam kernel: [46802=2E944484] Exception stack(0xda337fa8 =
to 0xda337ff0)
Jun  1 09:11:46 sicam kernel: [46802=2E944493] 7fa0:                   001=
c6f2c 00000001 00000037 0020ae40 00000006 00000000
Jun  1 09:11:46 sicam kernel: [46802=2E944502] 7fc0: 001c6f2c 00000001 000=
00001 00000121 001651c8 001ea378 ffff0000 00000006
Jun  1 09:11:46 sicam kernel: [46802=2E944508] 7fe0: 00000000 b3efea18 000=
00000 b6a2ff40

Best Regards,
Rainer


--skSlsODNy64ESaANZ9xD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6498): https://lists.cip-project.org/g/cip-dev/message=
/6498
Mute This Topic: https://lists.cip-project.org/mt/83330337/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--skSlsODNy64ESaANZ9xD--
