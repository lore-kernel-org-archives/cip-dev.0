Return-Path: <SRS0=ZUnv=5B=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6C1C3F2CE
	for <cip-dev@archiver.kernel.org>; Mon, 16 Mar 2020 16:13:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A002051A
	for <cip-dev@archiver.kernel.org>; Mon, 16 Mar 2020 16:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A002051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E0C04884C2;
	Mon, 16 Mar 2020 16:13:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3BSYjgAw0cui; Mon, 16 Mar 2020 16:13:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9EC4388443;
	Mon, 16 Mar 2020 16:13:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93101C013E;
	Mon, 16 Mar 2020 16:13:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE5ADC013E
 for <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2020 16:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A8DF08849B
 for <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2020 16:13:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K2rJ7e5Akq3v for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2020 16:13:00 +0000 (UTC)
X-Greylist: delayed 00:07:05 by SQLgrey-1.7.6
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B37C188443
 for <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2020 16:13:00 +0000 (UTC)
IronPort-SDR: 287B6d9gBGVSEbISM1rmoBA49gsnRo2EvgAsl0BA288fH+ey14FOqNmAZJlM4mnawe0SlLVYoI
 Wlo8nz0glmyeEnRlYRNzfnmqkpZfktPfEiqzB3BG1HTX3aIpFQGcR4glTAJk2twR8er9Nf1GpD
 k8w7MOimuOft+95wgNOJPDFKjKT+MgHJ7oNOxoBGnA4h5cY0cYQjMi9NoFRZ2rZlUkPOdNxzmu
 ZOs35tMQEuQpHjgQbSWktPsGMN78ArevUqcpzWe1kx7Pciw8kGyaF8GKOwAsDj6TmNJrWbFVLz
 wI4=
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; d="scan'208";a="46775363"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa3.mentor.iphmx.com with ESMTP; 16 Mar 2020 08:05:43 -0800
IronPort-SDR: peW4BlH8h9XdscniQXwRqLsxLayWysL204zeP7hBkSPXfawTjSpJUbsboiTd9JKZQp12iBWy0c
 R4WAh1xP+lzcWZan3+xDuYTf/CMC/YVr+tguuosDfz1BCzGrwOp4D4pzrzTpOgMRfr5Dhk48Eb
 oxR1lzgsNkuf1A1zs3JCBSNtEjagXBbQP8vWVgbB76NgRM96Mu1o2qzYFo9E1IAiKJf/PQqm1V
 D4Yg5OIz5ElXbAemsq01NcwygfZrP55eKySEnMFK4lQ9ihKiVg4bO/rmC/iBILKoDMHrO32XGE
 t5g=
From: "Bhola, Bikram" <Bikram_Bhola@mentor.com>
To: Pavel Machek <pavel@denx.de>
Thread-Topic: I need de0-nano testing for -rt release was Re: [cip-dev]
 4.19.106-cip21-rt8 problems on de0-nano
Thread-Index: AQHV9kP24swRbJhFDEOoDhesdkjwTahBz/4AgAG354CABeeHgIABuKsAgAA7v+A=
Date: Mon, 16 Mar 2020 16:05:29 +0000
Message-ID: <c5a6e8e3792b4823beacda579fe46019@SVR-IES-MBX-03.mgc.mentorg.com>
References: <20200303091556.GA10040@duo.ucw.cz>
 <20200303092343.GA11594@duo.ucw.cz> <20200303171049.GB24044@duo.ucw.cz>
 <20200303212826.GA16402@duo.ucw.cz>
 <fe189e62-baee-4f6a-cc19-295c4c023dc7@siemens.com>
 <20200309102132.GB18031@duo.ucw.cz>
 <c3f20059-7663-b216-a799-14cb943669ea@siemens.com>
 <78fd4f1df8034021ae195b8287cf2f29@SVR-IES-MBX-03.mgc.mentorg.com>
 <a9aa2dd7e7fd43eca840d7825e835ffc@SVR-IES-MBX-04.mgc.mentorg.com>
 <20200315094201.GA23740@duo.ucw.cz> <20200316115913.GA18883@duo.ucw.cz>
In-Reply-To: <20200316115913.GA18883@duo.ucw.cz>
Accept-Language: en-US, en-IE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
MIME-Version: 1.0
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Gumansingh,
 Smita" <Smita_Gumansingh@mentor.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] I need de0-nano testing for -rt release was Re:
 4.19.106-cip21-rt8 problems on de0-nano
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hi Pavel,

All these random failures are happening because of the slowness in network. 
Because of the COVID-19 situation and in preparation of all employees to work from home office, Our IT team was doing some experiments/setup by reserving some network bandwidth. That caused the slowness in network and the timeout.

The board is connected through network cable. If Root filesystems (etc) are not changing too often, it totally make sense to do rsync to pull additional changes if any. We will give it a try on that. 

I saw all of the jobs started working fine today again for both 127E and 227E board. But we may see these random failures as IT told to have these network thing will settle in another day or two. 

Sorry for the trouble and thank you for being patient. 

Regards,
Bikram 

-----Original Message-----
From: Pavel Machek [mailto:pavel@denx.de] 
Sent: 16 March 2020 17:29
To: Pavel Machek <pavel@denx.de>
Cc: Bhola, Bikram <Bikram_Bhola@mentor.com>; Jan Kiszka <jan.kiszka@siemens.com>; Quirin Gylstorff <quirin.gylstorff@siemens.com>; cip-dev@lists.cip-project.org
Subject: Re: I need de0-nano testing for -rt release was Re: [cip-dev] 4.19.106-cip21-rt8 problems on de0-nano

Hi!

> > Both de0-nano and IPC227E targets are up and running. I have monitored for test jobs on it and those completed successfully. 
> > 
> > Thank You!!
> 
> There's still something broken with the testing. renesas_shmobile 
> initially failed (okay after restart), rest failed:
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/12635589
> 0

https://lava.ciplatform.org/scheduler/job/12718

Going through the logs:

progress  90% (81MB)
progress  95% (86MB)
progress 100% (90MB)
90MB downloaded in 383.03s (0.24MB/s)
end: 1.3.1 http-download (duration 00:06:23) [common]
case: http-download
case_id: 403737
definition: lava
duration: 383.03
extra: ...
level: 1.3.1
namespace: common
result: pass
tftp-deploy timed out after 1283 seconds
end: 1.3 download-retry (duration 00:06:24) [common

You are not trying to do tftp over WAN, are you?

Seeing the download speeds... would it make sense to do downloads with rsync? Root filesystems (etc) are not changing too often, so that should provide some speedups.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
