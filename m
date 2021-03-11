Return-Path: <SRS0=o21a=IJ=lists.cip-project.org=bounce+64572+6272+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28991C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 11 Mar 2021 00:22:42 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F0D64F60
	for <cip-dev@archiver.kernel.org>; Thu, 11 Mar 2021 00:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F0D64F60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6272+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ANk9YY4521723xp5iLOeMgzo; Wed, 10 Mar 2021 16:22:40 -0800
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web11.29.1615422158196365775
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Mar 2021 16:22:40 -0800
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id LJRE21065A;
	Thu, 11 Mar 2021 09:17:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/rxsk2hJUVMxOzNNkyoqaC/p9XquhfgKRIuG+UItbGOAa9Vo4ZD3dmU3cdzS/mBGwtcYTV+mrktzbk827DH0QW1E6b4PeRhJUpyVqciaGN0jJp5RyvN0sGsZHkTOuavBr/PJikRca044YBhW8nP2VGrd9NbZFRoOcihbfzoXWBRfzn8qAatVyyH2zL0rLXWC9mcd3txlWXm92hufwxS4zfR8YjXpkfU7F6Rt9SgwQB2uZdW087iU/JlV/JYQF4ZFBmlky/Pa+V0ZUTpUBlNlmaSr7rzH8DER08Flh9Y/TMTwpqKS+VPUgBzXvuMPpVjyI4C7Fmebe2Q6t6Z5I6yKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+fl4uY0usUDgEVE4DN295Vawa8RT0W6/NzIkDI+H+U=;
 b=d8TNY6r2cRGmd5AlRmQR6i2tez3nqgj0MfV7LWE3hkj5xb+1FN0cwHjkxCDzKz2B77rnk70j3llgyB2toPE9CUTdNVFiDpHahcTVLwtJ0XqHUDiVubT+LsjbQSCX+PtWye4JUNVGlWj2+1wNUU6zz9Q9fhXyhEDecnhkWT6GFHdQuQGqN+ZdzG69X8Au+4bfmVL0DT0d7XFgzlsu0+c63Uy5pP46GSvlRdjlT8uKIRMAlq2kU9v6DHs/U9eJWpr3N89lbcqPtr5eTGkeqrJBal/OAxsgSeSlDEnHAW7tvOpzVS8COKa07YKanaVVl8VB8hJ8T3RBAIrQPetvbJytgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYXPR01MB1694.jpnprd01.prod.outlook.com (2603:1096:403:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 00:16:57 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3912.027; Thu, 11 Mar 2021
 00:16:57 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcWC9geH3PVZlYMSnSakK31ZVNvwg==
Date: Thu, 11 Mar 2021 09:22:31 +0900
Message-ID: 
 <TY2PR01MB4972C6B8D65CB31065A6043EA0909@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f1d9071-cec3-45d2-ca59-08d8e422fbb7
x-ms-traffictypediagnostic: TYXPR01MB1694:
x-microsoft-antispam-prvs: 
 <TYXPR01MB1694804285BA666269DE9101A0909@TYXPR01MB1694.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 ua+6dXwUUpg0VBVkqv4jngAD3oeUyzgfmJy91vXJkatk46arCaerX97RGoIDUV/yp4dsA6mNPFTAgtncva8qpXvl6a7beA/Vl3GJipKPsDDs5aPR3fD8W8SwxnnBuF1kIW8yxszYQuHU9nSxSpCEHAXLb7koyIxWv46nPQsE8CVlnqq9TBbsNqUlpvfFPuXW3Nn+XGzbb9yr1is2pz6wViAAdij2bSfSApISTjFjMDX4bDy8ZewEur6UO+WDxDxmdcmJySsAYDyrzck3L7PJMOJ7CUOSKDffbRpcPQWXacGzCrWwGHT5LX+h+vGHZUC7N4QkpK7xc1AUjhc4oNWvJ7jiL9qvdP1/k4D8nkojM3Ap3/zXW8fkDfjI146+TR7MVDgnIHud8s0CMeVVcu5tmU9tZT1VDazq8QXQKtX0it0G+a00YbC1kl/aRjXkP/TVcgvG+2GyAudEpN0l7VffHg9nnk2mvWj8Hzz09VhBDCQepwknjtzw1kdzuyjzCwhG+KLhz6MZHZKWIxbQaIgeOCmtNy4mZW6ZI5UieZxBBYlqU7THZSj4fJVceHdrmoHEUR8t6lfby3f5QEQVco1QNwZ9Hcdg8YZ0kJkXl8goeho=
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?QUZEc1ByblIrVFNLZGRBVGhVM3hxazBmdEdFSUhHTkExdGIrM1hEVVhX?=
 =?iso-2022-jp?B?WjYzb3Y3aEtMTHJ3SnpBbmw4Vy81ZjZqUk50K3NSck1heUVudHZWckg0?=
 =?iso-2022-jp?B?NDR1WHEwL0x4OUVLMTlCYTVZOHBDQWN4NVNkM1AwRW5Bek83aFBzT2oz?=
 =?iso-2022-jp?B?aDhkYkxpNkJPVXRsNVREMnJhRkNzOHRYcVBLeVErYis0MmZVNkN5SDR0?=
 =?iso-2022-jp?B?SkRSdGFyRHlJWFd6YzlBdlVsWTV0MDgyRHZFcnRVYmRoTVZFTXZQSWdV?=
 =?iso-2022-jp?B?OXpyd24vcnVuZXRDSFM1MGoyK0dDVTJXSUIyK1FvZk93V2pldEV6SnRF?=
 =?iso-2022-jp?B?cVYrQzB0enhDMjAwUFAxMEU5NS94ZkF4czdVNmZTTHI2c284eXlnd29t?=
 =?iso-2022-jp?B?MVhwOFh2R1ZGV0pxWWhEOXB5eFFHdDZNZlFTZTF4S2s5R2xiV2plK2t2?=
 =?iso-2022-jp?B?S25BL1l2VjlMNHJ1ZDJJM0hjV1IzZDErQ0ZsL0hYZmJpaVd6ak9YcjV2?=
 =?iso-2022-jp?B?U0JxQXdOUEIzSzdOYlhwZGVEbGYrMXRrYmpYZXU1TzVGOWdGb0E1ZnRl?=
 =?iso-2022-jp?B?TGg2dHJURHRBbGJWRFFXM25jQjVHZVVFU0ZIc3Q0eHFja0F3K1R5RVdF?=
 =?iso-2022-jp?B?RWtXeFFhMDE5U1o5MU9jNlJnRXJFNFVYaXNwRHFVKzBhditxUlZWNEZD?=
 =?iso-2022-jp?B?NGt3NU9wY3ljTGhOMk5iOHZEbVNSc2ZlTG0vZEs1bXdYSnY0dHdheWt6?=
 =?iso-2022-jp?B?UlZOdXFvMDNzaGwyZEpJaGFpVjUyOEUwVWRkaFI5KzRVMTdEUDFEU0ZJ?=
 =?iso-2022-jp?B?RXdtemV5NGlMNVI4VzFVYjNuQ3hKRmpBVCtTSFpBR3VzVmhUdklaKzhM?=
 =?iso-2022-jp?B?UFovQVFSdDBjZlEyVnpkTU9TaGczUGszUzJFMVJBaEVzZTR0eFBFVjhT?=
 =?iso-2022-jp?B?MXRQLzRUUThKeWhwb0VCYWx1a0t2NXNiYWVGcEFudmE3RXlSMmdPejYw?=
 =?iso-2022-jp?B?ekJMSkRvbTFldVUvd0NCRUdVbk9TVERjQldHb045dHdoU2M1SGtSVUo5?=
 =?iso-2022-jp?B?cGhGc2FNYmx1eitPakMwOHhYNUZzSVZtcVZ6RFZHYWxQT1MwMmlPNjFn?=
 =?iso-2022-jp?B?alloNmJkQ0c2NmNNM25vNDU3eGZxSi9QWHNzRGpjd3FHSEttbWxvWWRF?=
 =?iso-2022-jp?B?dDkwSGRtekR3TFNtRXFzclRlNDBHd291OFJ6d0xHWk1RZjBmM3FCUC8y?=
 =?iso-2022-jp?B?Tk1BOEp4UktyUitoTUZUaHZDZ3U5Ym13OGk1Y0dtNVlRQUVvdXVCSXV4?=
 =?iso-2022-jp?B?RHJqS0E5dk4yYVRhV2lGR2FsOUVQRCtLemgwakN0ejdXYzRXM3MwNVRE?=
 =?iso-2022-jp?B?ekF2M1hZNzhENFNRL1lseVZoRklNMXV6Y0QyeDNyVkpLb1BNUko5YzBm?=
 =?iso-2022-jp?B?aEx6amZPNHVLY3ZXWjJnc3IwMlh0VVBRNUFSZHpQRGVpdVhmTUNQeG5J?=
 =?iso-2022-jp?B?WEFCY1lMbzRXNGRzalVqUUczbTB0MnErN2VsWXBpMFBsZkdxQWRSalo3?=
 =?iso-2022-jp?B?ZmVFcnE4cFFLcm9MaHFUd0MrZVBPWHNDbTg4YlhkaGVXSVFQZnZVdmkz?=
 =?iso-2022-jp?B?c1c0c2hrZTNGSUtjM21ZbU1PNjlrWGpsWVh6YzJQeURLQm56dm1lbXZY?=
 =?iso-2022-jp?B?bVUzbERqdlRqcGFqNmdYR0gxUzg4azRLYVBtZXhEWkkvaFI3ZExKdHlO?=
 =?iso-2022-jp?B?WXhXTUVhZUhLaXk0L0hlYktJV20zV0drSlo4MUs2SnJidVh0ci90Mnp5?=
 =?iso-2022-jp?B?TzJBSlJSQ3hFM20wL2NseUVzdWZFcC9pcEtsd016Nk15eFhPK3FWbXVn?=
 =?iso-2022-jp?B?OFljQU1wbmFQK2lrSFZiMDE0ZDQzRlNJcGgxU2EydE4rL2ZES2x5SThQ?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1d9071-cec3-45d2-ca59-08d8e422fbb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 00:16:57.5282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +CLdURsLCcXCIlCtikpmgaKz+nyAlgUohlnDTPQMhTCRGkAiHHMYrZBhZ1iXue2ibcdiqw5I/yZPrwf4Gu6kbJZ7/X5Ax1kuE/hMQhbtaJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1694
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tlLAGqsCMjKGAbltm2S2y1W1x4520388AA=
Content-Type: multipart/mixed; boundary="fOjSm9cTr4Ln2wb9M4sg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615422160;
 bh=xxt/yt0QaqxMyLm/vpAtHZZLIKbGw23yAhnw8QbadIQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=q1TlQdTC6GV3No6755+aSPZOZP7VnXSQZW4aTreojX0AX46vEsLWp6yEBC406CSBdMr
 ytc8ous4qlM33IaH5hdRh20fq0jxIB88Ml7E8yRET3DZduHfbU04Dnr8i/uMrhqQoQj1j
 0KwaaoHMB7+dNAMELxebDo/jUx8RLGS9Q+8=

--fOjSm9cTr4Ln2wb9M4sg
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D3&day=3D11&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/03/cip.2021-03-04-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc

* Kernel maintenance updates
* Kernel testing
* CIP Security=20
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--fOjSm9cTr4Ln2wb9M4sg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6272): https://lists.cip-project.org/g/cip-dev/message=
/6272
Mute This Topic: https://lists.cip-project.org/mt/81242609/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fOjSm9cTr4Ln2wb9M4sg--
