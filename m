Return-Path: <SRS0=azax=JF=lists.cip-project.org=bounce+64572+6345+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F05C433B4
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 01:26:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A9761103
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 01:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A9761103
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6345+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xq5rYY4521723x2d1IqH6hAP; Wed, 07 Apr 2021 18:26:18 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web12.2059.1617845175834939619
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Apr 2021 18:26:17 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id IKVK24296A;
	Thu,  8 Apr 2021 10:21:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ7w7Qo24ATPWtwbeTXXX8lUt7yqZ9SKdNIgRYFxIHEMPIMtrUtVTjSMHvwWIfTLC5f8gZ3m7UmCdGCwas7KFzZYyN8ZMX7MlcXiwBnKR178zdg5Q/o7dzpMhXQsQZFgUwRt+5ZHFycktz2jayPHmYqyPTthmAUPwsORyPJFCiX+SX+x/mqj1kCvkZrEskHkUKZNUA73xTHeWpaM9hWF0siMciZyf14Rz17b7Uu5GICzk9G+8Z7XWXb///B6oxKHvExbVwc5I7z9Y7pWC/PfwWk8DOSu0FHwVYE5P8fQ3JQjDm36Cm+0KR+2LD+g2U+nX4wZ59i9u0vcZ7xZT43NSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPNHmfYJHW7HuAWF3vLgOo+uqLgs5fVAxdSJrD9I5Ro=;
 b=PL3CxyD2SZb9AkAL8dHiePBHBcLOAqoUOwRdgwhGlGcu3NqZCzCSLF2TdFnWPyY+bxuetQnWObiFkaaAP14+MaBQLdRAzfhTg2pWtn9TsFcQdFaKvzMNjvtlN5eezNSezRFMcJtYwMmFAOG9gA6z9K0WEhKF0LPa3ebzm3YtU4mP4Xg759pxqFpfGbOherwIgoLP/dD7GkKTI40KIg8TVw6s7591Iwmxcq6yOUV9GQfWKWDURNFaSIXmudM6wOJOG3/nJ8s00vZvbnvAnBgAcx92pf0UWC4N0WVhKJHY3zy1JgnndSX++xBHbeR30yOT89EPNnY4fVW3j4xb5Izu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSBPR01MB4967.jpnprd01.prod.outlook.com (2603:1096:604:7d::19)
 by OSAPR01MB3444.jpnprd01.prod.outlook.com (2603:1096:604:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 8 Apr
 2021 01:20:53 +0000
X-Received: from OSBPR01MB4967.jpnprd01.prod.outlook.com
 ([fe80::28c7:f138:a2fb:6d]) by OSBPR01MB4967.jpnprd01.prod.outlook.com
 ([fe80::28c7:f138:a2fb:6d%3]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 01:20:53 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcsFVrqgKwiFJ11Tbmd/RL/lav6tw==
Date: Thu,  8 Apr 2021 10:26:13 +0900
Message-ID: 
 <OSBPR01MB4967FBD09611EA3933319D53A0749@OSBPR01MB4967.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9091e908-411a-4386-a610-08d8fa2c8d7b
x-ms-traffictypediagnostic: OSAPR01MB3444:
x-microsoft-antispam-prvs: 
 <OSAPR01MB34443D8EFA76AE55A53300BBA0749@OSAPR01MB3444.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 lqIbU1YqbzyMGqdIbZg9+KcqldBWw5GLu6AteLIBu+R8GjwH/zY6QYchfMkb51rAsgLsnmqol7mfE02Gn5gTCblK2AcpsLpQDRU/+fCFKDmV9rUYxRdtnQy7n/mkdNj/O+OrQeOsvQILEi+g8f6eBWgSWbIsjYPbrLScGdO1wEdMFxAzEeEOPR9wS91Oy1mBmYaxehxmkWKNqxBdeNcGo0OYlLyr12el7llvxkW7SisUPixyXbtCO05LVKX7i9SzjSV/buydiK8FgExYn1BmTGh3d9lakhNKRxqHu4zSLis5iNCZem9m2tlKt4RJK9ZVGi5xPzWrHOMnIOyovNGZqePHnQnpfb876sYh+Pr7uBSq6hB7jKzO+IL9tjq4nRFEBYsYrZtKSrTFMz1U0tBn3/cF0ncVi9q486a3juPd9K4u5pjpgMOU4znsckzxH5buorvO3w2tr8loCoqAY4nJ41JShsKYovOrfqAPjfKo/VD/YncIlhG1XSEIeT/lt9rTmeOxpOP2xGIZGzE361RJ84PvaWHwVwmJGDj+OyANhUKNSf1skaPRj2wDGszuQMJys7Z8/ZUPEIWJnS0/+E/7lJDkOrb7Dhxpt4AoGSWQm/P2Yy/B2EsyRrjFtYuA1Mfjmrw99+gm7KtIauyDD+5OoYC4xUnb2S2HHG0ki9taHWJxDrAT2YTBI7N8wB9r8M8IVnyLrv/ghw4CHWNwkkCt8HVe88l/+B4n3nPvGwpKfQbJId1zZs41TWc4z1+1umKwwCwEspu7HVn7W+GbTWcetA==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?dU93azFQWlphYWI0U0NuMHNsdElqRFlSelRWZDRsbU13RS95Y2FjblUx?=
 =?iso-2022-jp?B?Vktxc3BKaVE2L2h2eWFsS3BBVmRSR0p1M2JaRFNmc21jU25TSTBtSEIr?=
 =?iso-2022-jp?B?VkNhUmNUVDczWHhLYzlKZTFCQjhTdFVpODltLzZRWFVadmdRMTV0SXF5?=
 =?iso-2022-jp?B?L3NONU43RTFnQnQvYVo2WE5hc3Y5Zld2YzZUVW5UaHVNUER5dUlFRCsz?=
 =?iso-2022-jp?B?OThaMnlCb2p2MlJ1aXlaZ0dsTDVZMUdnbjJSMjF2Nk8yRUlDeXo4aGd1?=
 =?iso-2022-jp?B?RW83QStqcVdCQXdEaG5yNGNjQm9kbm9CN1JCbWIvL0Y0QUMvWkdIUGpr?=
 =?iso-2022-jp?B?TnkzZ2tLR2dDVUFzbXBIdjlteFlid2V6dXlXWXBBdlJnM3hvT2FPekVB?=
 =?iso-2022-jp?B?azNjVTNZdHNQdzZoaFJBcW81OEhNVG94bjJvaTE4eHg5cldRSEJ3UVpQ?=
 =?iso-2022-jp?B?Y285ZWs1ZVk4NFF6cE9kK0Q2VHNJSDdjL1lSOWRQSmIzS0UzWVhQWVZC?=
 =?iso-2022-jp?B?TWUvdnpqd2xwMnp0K0J3SEZWUGMzendmU1BXRmcwRU1HTUtGOVRJZm1Q?=
 =?iso-2022-jp?B?RFV2SVp3YnJvelZRZjRKaUVSRjJTRGJUNUR6WllsL2hwcW1yWnFoclJM?=
 =?iso-2022-jp?B?R2lXcEMvM2tiNE9jWWdBNlRBNXlQUG5VSDhiMytGUFBqbmhpcWtlbE9t?=
 =?iso-2022-jp?B?UzBkTyt4U2xpeHZtMlQvd2pqcG1HV0FQU0hJTEtjMC9naHRVK0pUbk15?=
 =?iso-2022-jp?B?U2NReEFkYVo0WHdManhmcysxOWFsRTJuY1VXV0xrU2JCWUFqVnAxeS9n?=
 =?iso-2022-jp?B?ZndWdkVmM0xFd2VLQk5GcXdzSlhWQWtaSGYvV0dVcnNuQ25iMnJrTHh5?=
 =?iso-2022-jp?B?Nnk1MUQ4SXBvQXg0TkdSNytvWXNLa2MzTjRSbkQvRlpCQ0xvMFAwNzhn?=
 =?iso-2022-jp?B?RXQ3S0llU2lVOHUzUHdjMGlZMWd0ZEtja2ovaTJmMHI3MWZyc2FFeGVt?=
 =?iso-2022-jp?B?NDdpM0JLOTRZOU44aFFzZ0lpbk90NGZLQ3NyVlZGQm9JR3ExWkVHU0Ew?=
 =?iso-2022-jp?B?alhZaFR2bVVlemJOQTFiYUo2eHJWYkhwS3Z6bGVVQ0FoeU5wN055ZDBI?=
 =?iso-2022-jp?B?amtDRi91dFl4QlNVSjZzSThXT2tkOW1EQmhBNFE5a3dSZXF2ejJuUDdQ?=
 =?iso-2022-jp?B?aW1rd3hRK25UZlVZajkrVlZyc1ptK2FzaW5vdmE2M2pOendXWUg5bi95?=
 =?iso-2022-jp?B?L1hsTHZSSm5lNFNaekdmci93TXJ3bTY1Y2tpR2FHRGpFS0I3L3M3c2tH?=
 =?iso-2022-jp?B?T1ZkdmVmOFJKL2hoOTJuZ0dickJoRGhjN0FBNC9tSG5rNGNxRGhnSnl1?=
 =?iso-2022-jp?B?UGpKVUVUTHNZSm1Obk9ISXc2bzQ5ajFwZ2I1SkVmWVVMSEt4YkpmYk8y?=
 =?iso-2022-jp?B?TlNvaytTZFU1SXFHZW9TdnAreGVVMkovTTBPSDVNcHFVbmxWdTl5T1I2?=
 =?iso-2022-jp?B?QkhhSFlxbDIzRldENmZsT1ptL0R5S2NvUzlHWnFzT1ZiQ05keURGbnpy?=
 =?iso-2022-jp?B?cE9tVnJFZ1g3RVVmN3U0Ynp6cmJqSFBxVlByeHhraGl2SXVxT3pLeWpC?=
 =?iso-2022-jp?B?b05zbGRzTXE5azdobi91MnByN2Q1K1F1U2RQMFNNSmk5UlkrMExXWWlu?=
 =?iso-2022-jp?B?WTAxT1dGL29MNmJuQ0pKeUJsY1JKUXNSYTR1SnpPOFZUbkZyb0FEQ3pC?=
 =?iso-2022-jp?B?NnhwdHVwaG9TbWQ5QkJNMFcvRUN2U0tFS3VHMUdIMHo2YkQ2cjhlNXAv?=
 =?iso-2022-jp?B?djZ4R2dpeFdXeWRDODFpK1VGZlVlckxpWXhVZkhabkZrS2VUTHVhRVJS?=
 =?iso-2022-jp?B?RHFFdjdQVXZIUjZTNXNFak95cjc2Zm9GOGdtMXJwWVdlM2tENTFJQnJ6?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4967.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9091e908-411a-4386-a610-08d8fa2c8d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 01:20:53.1381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJSRGjm40SR7Au1r3pYZXbupe0G4LaxBa9v/NLh+w6e1cOd2WSwK4gHAtJTUrvce53BMEICwUudfLq1/4fMoTm2jFxHLXjbAwRzrJ5dW304=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3444
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Ie6Pyu0xjmg0oeUJp1fTWcyzx4520388AA=
Content-Type: multipart/mixed; boundary="ybkARe71uvc7TYIBU7x6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617845178;
 bh=206IHmXOjERecfFMrBq96nq9PtwWpaLYuJ1RyU9VqOQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=VwS+vJLe3lzqTJTqWEoXf1UDlOL8VCqQJlkRcx/6/wyr9edk4UI12gwsMV7otH+Cu+k
 4qpTjQuaWrDcYzW7SrlxkqKCRSOmIoETwpZgZiQvEpfKySVCfvtrlMRfF/XkaeBeVEvqG
 pO08y+ICHQJc3QG9VRLPZp7SuObZmJPWUqU=

--ybkARe71uvc7TYIBU7x6
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D4&day=3D8&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/04/cip.2021-04-01-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Ask board owners(siemens_i386-rt/plathome_obsvx1) whether X.25 and flo=
ppy can be disabled - masashi910
  4. Monitor the status of CVE-2021-3444 and CVE-2021-20292 (3/25) - Kernel=
 Team
  5. Monitor the status of CVE-2021-29650 (4/1) - Kernel Team


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

--ybkARe71uvc7TYIBU7x6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6345): https://lists.cip-project.org/g/cip-dev/message=
/6345
Mute This Topic: https://lists.cip-project.org/mt/81932192/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ybkARe71uvc7TYIBU7x6--
