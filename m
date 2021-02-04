Return-Path: <SRS0=rj8C=HG=lists.cip-project.org=bounce+64572+6161+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1130C433DB
	for <cip-dev@archiver.kernel.org>; Thu,  4 Feb 2021 00:03:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223DB64E27
	for <cip-dev@archiver.kernel.org>; Thu,  4 Feb 2021 00:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223DB64E27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6161+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jT0CYY4521723xht1VGRHSJR; Wed, 03 Feb 2021 16:03:56 -0800
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.web08.79.1612397034257160863
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Feb 2021 16:03:55 -0800
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id EI6I08908A;
	Thu,  4 Feb 2021 08:58:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBTjphEpE+CVKMswdcQhYMmUwegO1AVuaTFhVx06s0NsR5DL2NKShdq+POp4RzH6M1iRkq+FQCNHXTTEy0KofXmcEQjRnE9SyGDPvseDAI5MqSTp78k5KYIFtsHVoSFgK93vM/rN1sKiRfJBcq9/plIi/kFAKmRT1Vr9xSyyylDYkJeqMHAts2VU1tSaPZ6RJBFlAtTNR7jh/zq6Z7r7dVKeuqNhuhHwIlB7UFOhLUPW08hFGGWhtD0yJjsSD8peewQ+Dszwm/PAdw1mcoVQvuc37LCawYyW2ICHugkR+hkMHI8IHviGwQuDdy/7H4MFC8Jgut/AIGl91lFKBGfAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLSbrY6P9kb0cgDtVUwa9sVfNIwUQojQndEk6SJfBMI=;
 b=Vf/OMYaRO/8PHTI3dchwALcWS2mmmRk7zZTgxrDO+3Hq1OUcmlnWVNs4jsa0izt4wwogOKfFIGo9neSxifVM+xsVMc9GhfpSvuUVk2QKfpmxK7iLL7vnrJm+bC4T06iAIfp65hbTP3ysgZr3gOh1AyyKHIYXJEOdhwrEYZMQtHbBSo8Es2ExAO0p7WeIgXuBTFG8J4VuASqhwGiz/4PmLmzipd5btjK9fAFIc/4h4nLCCnxpntCTU+RfJzl5B5f/h3eQbmj+WCPTSXXVn45qZx8KsJiiI6VpWkzgrW24bIef6ziKVMC4G+6+o+EgYpQf0zfcHJc8cEP42EBJaSBrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB3613.jpnprd01.prod.outlook.com (2603:1096:404:c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Wed, 3 Feb
 2021 23:58:03 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 23:58:03 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: Adb6iENxGVhTb0feTA+r2jFv1+nRRA==
Date: Thu,  4 Feb 2021 09:03:50 +0900
Message-ID: 
 <TY2PR01MB497246230D4367AE668FE17CA0B49@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab3fab57-ffee-4d28-1a70-08d8c89f8b41
x-ms-traffictypediagnostic: TYAPR01MB3613:
x-microsoft-antispam-prvs: 
 <TYAPR01MB3613024CF07427BE2D4468D0A0B49@TYAPR01MB3613.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 GZp58Prm4bX9rblLgcAv55Ug1A7sU+AYyvg0GxOStqAE/EhKeRxw4gXhq+EjFWfNsRrUv5aha5OAZCa3us1aK07HJSgzyfFpnB4WgYoeAWNaz7V1QgoII1wjKyVBVqUn0HB1tYEbCxMxGokcSoSZI52TP+7jt/V/YAGe5tSWHKSwpM+mpFcRFw1NaaTzsB+qy0Jmd4J/so4vDCTNXLxm6Rxr9XsI8N0IFkPUQBlyOrb3uRMXTSw1Oc5b5n701zkLDURhC8m0vOM4Cot5WDA1le0LXCRrqCfJSINMyDv5685g6Z7HZHPDr9/mIMhQF4IcmBN/0IFhyTTXMkDj3B0kuZ9scydMfjuVwWxQkyyVpI/+yJQwxk6IdQYmKbExuzD8wSyfHboqHVkCym3teJnotMmY+enpbTKTYZpMkhtgtFjy6YbRWM8udfKZkk7DiRtXjxWSr11cC6nZvfJNJL5CUvMz3KI8BAjTVzPnB2uOiQcbbcaBsVkblLFiA/SwHjdGzk7UH4QGw60eF0KZWMyXtDSjz+L7bDAswpdVh4Be4FHEJjBa/AkKl3yYqSHHyMiWVasvxSZHNCrIYLVHdh7BOUduYffunFQ1Tcus0YnzNq4=
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?WmxtSTMvamF4cU1vV2MzZWlLVHlvaVVuTDRQNWp0QW9jaEpKcVJhSWc4?=
 =?iso-2022-jp?B?dkFGUlY0eUtyRWUwcTNDSmNJaDdtOXdFN0hZUkJQbXV3QVQvTE9xUFQ2?=
 =?iso-2022-jp?B?T1RkclhxYXdHOUN1bWpDN3BvT0RSb0Q5N0JWS2xJUXZvckpoN28ySHFX?=
 =?iso-2022-jp?B?UW84RkhSRFpmSWRyVmhiRDNUd05GNUMzWmZhaDZQaFNOanNyUllSRlUw?=
 =?iso-2022-jp?B?Mi81dWlkTVdnR1Foa1RxbjdhRVNlVEJwV2JUTnphTDBJMExMQmI0T0s3?=
 =?iso-2022-jp?B?TnJFZGk2VjJuSFZQK1kxZy83T0g5MndxNk1PTGM3Zlp3VmtpZGdFSkNY?=
 =?iso-2022-jp?B?WXpUalBubEN3S1ZiZFV0YWcyL01EMDc4NWVLdlJZN2ZTRmdoMk1GVFox?=
 =?iso-2022-jp?B?L3YxcUtnK3BLdTNqWjhRQktTZGR3K1FUWEpudkN2THZyQlNSSjc2L2R2?=
 =?iso-2022-jp?B?dFpkdDllK01vOEJmWksxV21uSDNwQ0lOUEJHa2hrSENtSFZKNC9QNWxq?=
 =?iso-2022-jp?B?dkk4SHUvVzlpRUpFbGs3S0lpZENGV3FwMkdsRXdEWWEwMDlzL2d2bkI1?=
 =?iso-2022-jp?B?ODNUamxtSW5SbU1iTUFBckJ1SHNKazd6K3lJUVhaR2JOWWlSOXB3YVZu?=
 =?iso-2022-jp?B?K1RXM2xpRFBLTkdaVVJjK3lTcEo0VEp6SjJSaDZ3ZGh6Y2t1dlBlM09E?=
 =?iso-2022-jp?B?S2dBTUdyZE5YdmVCUXlEaGZPS3dFajNFaGF3ZVM1OWN4dFBROWVJYTlP?=
 =?iso-2022-jp?B?N3ZkVmZLSmdYMFJrRWhtdTNpMlQrT3J2R2J2NFdOUCsyVHR4N2VJcmQ2?=
 =?iso-2022-jp?B?QlVNUURDQUFCTlZUVWpudTBPSmQ3MWViM0ZubjhEL0d3RXZpRGFQaXYy?=
 =?iso-2022-jp?B?ZlhhYnFxcEYvWXpGUXhUZ1Z6cEpHL0x5OWNoK3lvRE4xQTY5Z1ptSXR1?=
 =?iso-2022-jp?B?QWJta0l0aitLVS83UkJhUTNnUTZwdERCWnl1ZjZ5MzJWczlkSkJocDhp?=
 =?iso-2022-jp?B?YXBvNmlSeTJiZjJFOHhIakUrMERURW8rWFNtOHJqak8xeXd2VFErSzMw?=
 =?iso-2022-jp?B?cEI3aWF4a1AxYU4zZ1VTYTVJWFU0ZUxNZVBWT0p0WHc4MFNidVhXYThk?=
 =?iso-2022-jp?B?Z2lMU2wvYzJYZzJjK1NyZVpibkN2OEdJMll0NjRwbVRkUHNSTFJCeFFu?=
 =?iso-2022-jp?B?dnJXZjkrSEd3ekRiTHBqVHZ0ZSt3azdRb1Z5Mk1jY01lR1RlM2g0UTBn?=
 =?iso-2022-jp?B?Z0x5M2Z0eC9GRTlwWkZWTUhTWFdGOXdwUEl5SkFMZE5EekdkWlU5YUZR?=
 =?iso-2022-jp?B?ai82ei80ai9mM2NGRDdqL3dMdG9wb0xrZEkrT3NpTGtrRmh6MXFmbkkz?=
 =?iso-2022-jp?B?OVdaa0JOWENwUGhadVljdGtiMytzTmFvdDVXNVFnREE5QnN2RlhSQVlr?=
 =?iso-2022-jp?B?TnExZEs5VlFXM1FNaUovT29jYk9BejU1dTU5dmo3Qk84dU11c0h2Q3NT?=
 =?iso-2022-jp?B?YWJYSjFnSSt1U2h6QTdvNUltZG9wUkpnOS96NkZVV1J3ZU9NVS8=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3fab57-ffee-4d28-1a70-08d8c89f8b41
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 23:58:03.3280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otV6vWI+995tn3yY7hgh3lCKyFglIgcioWYDqltaQ6ey1QepD3/OpsabLx6GPdRPedlpePq+qym+g4dbGDYDm7Uo6D0Kxb3CvtJ7tsWtBS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3613
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kPEdh0fnFsVN8SHZT2YQyQxGx4520388AA=
Content-Type: multipart/mixed; boundary="ocsfGB6EX40jD6jZg6GO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1612397036;
 bh=SSKHKDJgc7REHt6+nKNxOgMDqzzdMa2aFjqI6PPupTk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=C14FqYv6ZAfalDAjxhuHfmIWQCdxDHAfW9xLL6ogpLJkUdUgJx4fK2XQWd4GsnRmJ/P
 03O9oqz5rdk+IORZ2jpoUT3mbtW6UvJkJPIEaQIJTzaRBdiat81aOCv0dsyV039iWJ7UE
 1KeuxfHYBnx5LXUB/gN0tL4Rz1Ja4A4LJtA=

--ocsfGB6EX40jD6jZg6GO
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D2&day=3D4&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/01/cip.2021-01-28-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] - H=
itachi-team

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


--ocsfGB6EX40jD6jZg6GO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6161): https://lists.cip-project.org/g/cip-dev/message=
/6161
Mute This Topic: https://lists.cip-project.org/mt/80368913/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ocsfGB6EX40jD6jZg6GO--
