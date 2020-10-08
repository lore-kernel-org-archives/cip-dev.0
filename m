Return-Path: <SRS0=8uCk=DP=lists.cip-project.org=bounce+64572+5504+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B877FC433E7
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 00:56:55 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF4E20882
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 00:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="l5r4CgBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF4E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5504+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id REMDYY4521723xUQBkh3xJ7b; Wed, 07 Oct 2020 17:56:54 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.113])
 by mx.groups.io with SMTP id smtpd.web11.1584.1602118612564655540
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Oct 2020 17:56:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSA2CsYIVVYzDTl2uZItDt8FMo+OfhSZj8x9KwYAnM/nZpqCOGUHpzVOe/bSITmp05xjj821bcFY8iB6EenMz9FrzlUZhgGqHeJTdnAbmusv6elguB2OtMPorYCp46iGnD/gYpV/b3uuCDpXzxJHG8GSW41TOvAQGUHqs9P86iDK4go/7JZWRFbsduT5uV4868EdLWKDA28+n0JFKqPMU4TZcluF+H+lHtCwz7v+2ovOS7HxP9CD9jjHSwHmOHEtVZOtEFS2GWGJdvsHQe3EG7wtyGSUvMMYe7UsBcDB5X+aWiXdaHc7OlzKD6gZnD4Vx2TYpEKHEOAclg8URTUPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYtzYgI776ZWrtS14teX9v9sijnB0xbuEMKDl24D/Ms=;
 b=ffTm3a1HMewywcQUlWf1r5ZZlzkjsoy5eQE83sowUJOK9AsGRHW69pL5auOQR4N9xizrjMGJocMcZmc3PmNdCRoT3MXmTvuJhC+jdNK4R/eMSdu0mbDpAjAStZ6zclk01+oqeci3iHsueoB59DmtHQf3cbBWyN9vNlikVk7cRO+GyeYtTuOPkKBf7i+bjV0QXEs8PTLfXkfzgyc08ZbvaeQt6WhKhQWB+pG6a48J06SlzDYonvbVBzRsZ15+xDzvXaGybMLOamdgt61b5y/zUFjBE79NHihqMDz1wMAupGn1FhVdrDtjDUEBB+HcfaiPsiVdrA4KwpWO9BEKN2EnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSBPR01MB4967.jpnprd01.prod.outlook.com (2603:1096:604:7d::19)
 by OSAPR01MB2978.jpnprd01.prod.outlook.com (2603:1096:603:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 8 Oct
 2020 00:56:47 +0000
X-Received: from OSBPR01MB4967.jpnprd01.prod.outlook.com
 ([fe80::ad11:c97:9cc2:4c49]) by OSBPR01MB4967.jpnprd01.prod.outlook.com
 ([fe80::ad11:c97:9cc2:4c49%2]) with mapi id 15.20.3433.045; Thu, 8 Oct 2020
 00:56:47 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdadDdEK75ALNrT6TDiJMlv9gfwWTw==
Date: Thu, 8 Oct 2020 00:56:46 +0000
Message-ID: 
 <OSBPR01MB4967B53707E24AB20B083FA0A00B0@OSBPR01MB4967.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14f31ffb-e0c8-433d-b983-08d86b250879
x-ms-traffictypediagnostic: OSAPR01MB2978:
x-microsoft-antispam-prvs: 
 <OSAPR01MB2978DD6D1F0C941D6D9DD817A00B0@OSAPR01MB2978.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 XgDB1hkNKR4aq6mXe/EyM0lLzwe8GBCyaVa7cr18AWbmJmRXUxD2bJWvI1GRuM2tI5zV8euNw6RX89LTSK6TNDvAlmimDrj69rzgP404RGGTkk8EtIOKfNaG1/w3WOjpOaDB+u7Xhyur66/FPmbTtW6SJHI78Qi6cBOBy7Nh8s8S4BfuH/e0uUT15SVXncvaqu68VMkGFlM1RakizZx+KY1hJrpvHSbHMyiSKEhywATOHsKLLvMfnZsjircjPCu/JAy1A/BrPsrIrIbWbEe5XuqVF9IxxsqG/jTyGP/EF21+miVzJLz/vP70GkJ+CVvSjOiSO1cGMB1AeBobYtVRexoQXIUJPh5Wqnhu+8upiDRUI8KGutEjM1sYImsDJ5Ba7spD6Wg8BcR95PjsrD1U4g==
x-ms-exchange-antispam-messagedata: 
 mG3IMJaYiBiLG0Pune/4x31iG/F8NT2egaRcy6VDxkolK0T78drny68KEzFnjIS7LivQLP5T/Fpo6ASJkFk1wpQLT/kxgAYOs+Ba2IJVaiTOSP7XamWZylIJ0HcrGRM285OZvH4iNBoy5CrVWTEr4daA3hmfTri6SQ1kCl9oRv25AHwxqdLatXt6VnBXMumjASzuJ0DZVZDRrxTucb1qNCaZTTQF6LJdv5N2yAth/WnFcsqZnyz2lmEFVS8g//uw9iExa+uF+g798V/5XqRx8O4nHnka7GlD87qQVGjKbGFx+L36K/2BLCSW8RsC+HUzCfBYjxxSnfxz5KtnVVgSq44FcsGpI1DMU/4pGDBYptuGDTgTqwovAE42+/7iY4dVEoOn38EfHrgiQDxjCQXT15Tn5cSQrwKjwqlHxWP4xLTTxfVWSB+DyluV3nDZKMe+ex2fC3NZXHiHg9UPp89pY+wJHncsXFyxWQyTpBjVYbhQrbV+3USHGp0cgMMsJTj8mT1oa5fQYcLFG+VqtS/BssZcz592gUf9DPduoKJRUDb31Mv92kkJBfZcoaP5FlFz50Vcs3nsy2GWhQyDX4jVeqwm5mUsHEtwmIYxQ9Mzz0N8TVmJYmOL/SFmX8uXIM7OLxgfYtPhObNHK5CcdhEFmA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4967.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f31ffb-e0c8-433d-b983-08d86b250879
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 00:56:47.2222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPggZRY5dxQD0BXIL87+qwABDTjJ9y9Ggm3xRydrrKNzJD9d5a6/XdbfwM8FgHOOa7HeEvjqqJD6CZEkOyKFFTHBDJ3JWbwTPbHcsf4g7YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2978
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tajVvbVljoueszE2urWRmNktx4520388AA=
Content-Type: multipart/mixed; boundary="Mr0eesj4hpD5fzUBQaoC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602118614;
 bh=4la2LaeAYifPriTYwkLTJK/mwjO63oH8wmSQYWxZJVU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=l5r4CgBN4kIMaEniUsubazqjMpiy6+oTUQM8m3V/F4K70HKNBpVcb8rFNIPQB4KPakL
 dSWw27vio3n1zg7S1UQNX4aXJm6hRm/qdAupnwGUGzI0aE7oucomfxnxVg8WXbHikPWxU
 fgrOkbEZWAGcbRQRrhyN3iO+TrzCwZuOxRc=

--Mr0eesj4hpD5fzUBQaoC
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D10&day=3D8&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/10/cip.2020-10-01-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Check whether CVE-2020-25284 needs to be backported to 4.4-rt
      ->  Delete rbd ( Ceph block device ) from 4.4-rt x86 config - iwamats=
u=20
      ->  Done, so will be closed today.

* Kernel maintenance updates
* Kernel testing
* Software update
* CIP Security=20
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.


--Mr0eesj4hpD5fzUBQaoC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5504): https://lists.cip-project.org/g/cip-dev/message=
/5504
Mute This Topic: https://lists.cip-project.org/mt/77375242/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Mr0eesj4hpD5fzUBQaoC--
