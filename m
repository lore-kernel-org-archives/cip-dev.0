Return-Path: <SRS0=jcVZ=LB=lists.cip-project.org=bounce+64572+6496+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3E2C47082
	for <cip-dev@archiver.kernel.org>; Mon,  7 Jun 2021 08:34:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C4B610C8
	for <cip-dev@archiver.kernel.org>; Mon,  7 Jun 2021 08:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C4B610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6496+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JYuuYY4521723xzFKngljAC8; Mon, 07 Jun 2021 01:34:07 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.33376.1623054845943349332
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jun 2021 01:34:07 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1578Y0Gk014226
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Jun 2021 10:34:01 +0200
X-Received: from [167.87.243.185] ([167.87.243.185])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1578PM8M010726;
	Mon, 7 Jun 2021 10:25:22 +0200
Subject: Re: [cip-dev] BUG: using smp_processor_id() in preemptible [00000000] code: TCPTSK/1809
To: cip-dev@lists.cip-project.org, Rainer Kloud <rainer.kloud@abwesend.de>
References: <trinity-6c08d14f-96d0-4b01-b81c-dbc85783818e-1622901051584@3c-app-gmx-bs72>
 <20210606191433.GA18130@amd>
 <trinity-17b11b5f-9805-4527-89fb-1f3a0103a164-1623043418611@3c-app-gmx-bap15>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <458aad5e-5455-e290-5ee1-f5eb78fb5c5e@siemens.com>
Date: Mon, 7 Jun 2021 10:25:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <trinity-17b11b5f-9805-4527-89fb-1f3a0103a164-1623043418611@3c-app-gmx-bap15>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: muvHWWPvdp8APiF6HASMLtzRx4520388AA=
Content-Type: multipart/mixed; boundary="WL3HvPeua53y88bhiJ6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623054847;
 bh=TG7f0qC2MHImsR7Laq/JGISvesoP1mlb2dhJMHODEvs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=pUjKjHfXSMCOkZLoqWraUjxNljZnwxIWnim5YFqCcIda6q7md7dqC48hiaHz3yh6gTC
 mpLYUVoI0b7nJV2Hv0h2APC+R8V/EJwQLHLAZ6CZjntGtcKY8u1OVWimvpGCxRBqXY2dp
 U+f5soc8tk7oZbyNhWZaY90OcP+iZpax+vM=

--WL3HvPeua53y88bhiJ6l
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Rainer,

On 07.06.21 07:23, Rainer Kloud wrote:
> Hello Pavel,
> 
>> I notice you are using -rt kernel. Do you actually need realtime
>> features?
> 
> Yes, I actually need the realtime feature. I have one task which
> needs to run periodically in realtime (triggered every 10ms by an
> external IRQ).
> 

Please don't forget to share your kernel config with us so that we can
make sure your use case is covered subsystem-wise in CIP. From Siemens
side, we still have room for improvements in this regard, even more on -rt.

> Jun  1 09:11:46 sicam kernel: [46802.944299] [<c062f854>] (dump_stack) from [<c03a57ec>] (check_preemption_disabled+0x110/0x114)
> Jun  1 09:11:46 sicam kernel: [46802.944316] [<c03a57ec>] (check_preemption_disabled) from [<c014163c>] (migrate_enable+0x40/0x488)
> Jun  1 09:11:46 sicam kernel: [46802.944338] [<c014163c>] (migrate_enable) from [<c053ff0c>] (ip_finish_output2+0x21c/0x460)

Migration should be on across migration-disabled sections, that's their
whole purpose. But maybe the check that preemption needs to be off when
using smp_processor_id needs relaxing to at least migration must be off.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--WL3HvPeua53y88bhiJ6l
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6496): https://lists.cip-project.org/g/cip-dev/message=
/6496
Mute This Topic: https://lists.cip-project.org/mt/83330337/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WL3HvPeua53y88bhiJ6l--
