Return-Path: <SRS0=wJNi=K7=lists.cip-project.org=bounce+64572+6493+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D96C47082
	for <cip-dev@archiver.kernel.org>; Sat,  5 Jun 2021 13:50:56 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D3F610A2
	for <cip-dev@archiver.kernel.org>; Sat,  5 Jun 2021 13:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D3F610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=abwesend.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6493+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kKCHYY4521723x4HB3cdrLh8; Sat, 05 Jun 2021 06:50:54 -0700
X-Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by mx.groups.io with SMTP id smtpd.web09.12374.1622901053605667994
 for <cip-dev@lists.cip-project.org>;
 Sat, 05 Jun 2021 06:50:54 -0700
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
X-Received: from [165.225.200.169] ([165.225.200.169]) by web-mail.gmx.net
 (3c-app-gmx-bs72.server.lan [172.19.170.208]) (via HTTP); Sat, 5 Jun 2021
 15:50:51 +0200
MIME-Version: 1.0
Message-ID: <trinity-6c08d14f-96d0-4b01-b81c-dbc85783818e-1622901051584@3c-app-gmx-bs72>
From: "Rainer Kloud" <rainer.kloud@abwesend.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] BUG: using smp_processor_id() in preemptible [00000000] code: TCPTSK/1809
Date: Sat, 5 Jun 2021 15:50:51 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:AmMyUEG80UiHU7J8AHMWCxO83NsjAwwOBgkjc3dOnse5uFBnUrvIT3Bp67dsQVQJRALHb
 cZFYQq9wV6plECA37d6vrAzAp+5KWkR9DKHcmina8YzoWzaAD1S59ZopAm0CZubUJ+AqQHa8FbIv
 KeYH1H8sAMdcDiQtWYMLL6XrjQDoq06iXFp7BTKAEYSTRGCLwDEPe6roniA/B0QV+G/W0d3ja+06
 zZAlR9cpvUOj+KcAvvbTb3zLM4Qr5tj8mfMN2xegtVtj3Qo38+ImaVoH+PG8R7c9AKg3BZt4+PkE
 gY=
X-UI-Out-Filterresults: notjunk:1;V03:K0:nV7tiL6ANhg=:O9a5+OP9ixjahYYVtY/mce
 y5R9a3S5A9A3Hv9n/71VHRzJwBUdlTvj0qXyOq6Jo4ViilEe5ksnFGJyeF9gK2tNugAwveXA2
 UoXu5UYO4qaU03LpD17qCSSfyNOfZEv3Wmb4A7zjNudMVrKG3Dvlw2Hpmyw90N+Ar0KsuJ6ys
 2Sao4CAy18p05Yxp9mq3zYB2jybMECBjzwnd2J4J2kRgJYCe3cHdcr8GIiEJOMmaa8wQwVLoy
 rK2zuKjTi7ayT2bRJydGaXRgTGOiPjAWqZsRFd6o40zwjz68vwcFW+WORRrBuxj679C8Zh7eB
 4yF4ejWlGHolDgTgGEOTHTjcnYkxNE11w/tidU1MV3ckfKhHqOFilmHg7HdSfREUVcEjamDRV
 mROJtjBk8yBugumL5GmTAjXXr3HZcEoJJWni156nvw8AQZF5ZDy/Z+dIEHbUudqg1sLIEnnpL
 cQq63WQNLp5yXOvMhWT16tKcp3wPOWxQdDhNgd9KX2mBAa90DwNRp/8xXbxSiB3xOkCpiNcYg
 DQ5n7YlwL3dZiCwZjEFeddwdg6jTRwiwSV3BZ7KTql+lbHhPZFbO9DmbPnPoYeosXdENzHzhB
 fjcgWDbW2zM9tBx7y+avW6ch9HphdZ3ae+NsrMtEV9vbmvxiw/FQLOUM6n5VMIvnKP0DSjqgv
 MrEBU5HDuAKALzZzR0x/4+K9kTbyfjhYGFEjnoepbROHJ3NUTrvxvDtzFZiUBeZC3PYo6sbd4
 M89+JKz8Enm2LWhQeX9vrBZLHw/79g+dwjsOA30SjKOjLHL2n1LOuJCwPl72agJCKRLWeyukW
 VPVhPD9z3pe3ZRoCvi+8GZNl6j6Zz2C6sucsSiDlykVzCO8ckA=
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2teMf7IETrbHYNWQTxRAA5gpx4520388AA=
Content-Type: multipart/mixed; boundary="0H2flWbGfJg6Yy2VkfS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622901054;
 bh=BLs1W3t5Ubs5FDYllW7o/8wDVYZb56uIlqJfJNzMxks=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Lh7YbNTUKhOeyTc/n2Smu6NL+M/r7ruN8trGtQGozl5qHgfrHOHIOBbnFGpP0/d8ljt
 8XEeVoWfQ4Efxg4N4lkMI59W9qx9Tb7NVHSP+jhf3r/1BphfIZ5WVzdU/9ohyEn1OQfmy
 npviIH/4pKLT7W7R0UjsyaGq6WQHmnebF5w=

--0H2flWbGfJg6Yy2VkfS6
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>Hi,</div>

<div>&nbsp;</div>

<div>I&#39;m useing the kernel&nbsp;4.19.165-cip41-rt18 on the Altera SOCkit and I encountered an problem with high TCP traffic.</div>

<div>I get the following kernel message over and over:&nbsp;</div>

<div class="signature">&nbsp;</div>

<div class="signature">Jun &nbsp;1 09:11:46 sicam kernel: [46802.944165] BUG: using smp_processor_id() in preemptible [00000000] code: TCPTSK/1809<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944210] caller is migrate_enable+0x40/0x488<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944221] CPU: 0 PID: 1809 Comm: TI4SDTSK#135 Tainted: G &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp; &nbsp; &nbsp; &nbsp; 4.19.165-cip41-rt18 #1<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944225] Hardware name: Altera SOCFPGA<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944252] [&lt;c010e9d4&gt;] (unwind_backtrace) from [&lt;c010b9f4&gt;] (show_stack+0x10/0x14)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944272] [&lt;c010b9f4&gt;] (show_stack) from [&lt;c062f854&gt;] (dump_stack+0x94/0xa8)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944299] [&lt;c062f854&gt;] (dump_stack) from [&lt;c03a57ec&gt;] (check_preemption_disabled+0x110/0x114)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944316] [&lt;c03a57ec&gt;] (check_preemption_disabled) from [&lt;c014163c&gt;] (migrate_enable+0x40/0x488)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944338] [&lt;c014163c&gt;] (migrate_enable) from [&lt;c053ff0c&gt;] (ip_finish_output2+0x21c/0x460)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944353] [&lt;c053ff0c&gt;] (ip_finish_output2) from [&lt;c0542854&gt;] (ip_output+0x140/0x184)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944364] [&lt;c0542854&gt;] (ip_output) from [&lt;c0542128&gt;] (__ip_queue_xmit+0x134/0x40c)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944381] [&lt;c0542128&gt;] (__ip_queue_xmit) from [&lt;c055cf70&gt;] (__tcp_transmit_skb+0x53c/0xb20)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944392] [&lt;c055cf70&gt;] (__tcp_transmit_skb) from [&lt;c055e188&gt;] (tcp_write_xmit+0x27c/0xfd0)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944403] [&lt;c055e188&gt;] (tcp_write_xmit) from [&lt;c055ef10&gt;] (__tcp_push_pending_frames+0x34/0xa8)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944413] [&lt;c055ef10&gt;] (__tcp_push_pending_frames) from [&lt;c054f5cc&gt;] (tcp_sendmsg_locked+0x66c/0xc40)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944422] [&lt;c054f5cc&gt;] (tcp_sendmsg_locked) from [&lt;c054fbc8&gt;] (tcp_sendmsg+0x28/0x3c)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944441] [&lt;c054fbc8&gt;] (tcp_sendmsg) from [&lt;c04cb3f4&gt;] (sock_sendmsg+0x14/0x24)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944455] [&lt;c04cb3f4&gt;] (sock_sendmsg) from [&lt;c04cc6d0&gt;] (__sys_sendto+0xc4/0x104)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944467] [&lt;c04cc6d0&gt;] (__sys_sendto) from [&lt;c04cc72c&gt;] (sys_send+0x18/0x20)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944479] [&lt;c04cc72c&gt;] (sys_send) from [&lt;c0101000&gt;] (ret_fast_syscall+0x0/0x5c)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944484] Exception stack(0xda337fa8 to 0xda337ff0)<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944493] 7fa0: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 001c6f2c 00000001 00000037 0020ae40 00000006 00000000<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944502] 7fc0: 001c6f2c 00000001 00000001 00000121 001651c8 001ea378 ffff0000 00000006<br/>
Jun &nbsp;1 09:11:46 sicam kernel: [46802.944508] 7fe0: 00000000 b3efea18 00000000 b6a2ff40<br/>
&nbsp;</div>

<div class="signature">After some time (normally 10 - 18 hours) the kernel stucks completelly. The TCPTSK is a custom task which has 20 TCP connections to different communication parners running on other hardware (PC, RaspberryPI, ...).</div>

<div class="signature">&nbsp;</div>

<div class="signature">Can anybody tell me what problem this message triggers?</div>

<div class="signature">The check_preemption_disabled function is called when smp_processor_id() is used. This function should be called with preemtion disabled, but I think migrate_enable will allways enable preemption ...</div>

<div class="signature">&nbsp;</div>

<div class="signature">Thanx for your response!</div>

<div class="signature">Rainer</div>

<div class="signature">&nbsp;</div></div></body></html>

--0H2flWbGfJg6Yy2VkfS6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6493): https://lists.cip-project.org/g/cip-dev/message=
/6493
Mute This Topic: https://lists.cip-project.org/mt/83330337/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0H2flWbGfJg6Yy2VkfS6--
