Return-Path: <SRS0=Pymb=HU=lists.cip-project.org=bounce+64572+6180+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EDFC433DB
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 00:09:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8031964D9A
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 00:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8031964D9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6180+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cc8eYY4521723xGZAcnzKkEC; Wed, 17 Feb 2021 16:09:24 -0800
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.52])
 by mx.groups.io with SMTP id smtpd.web12.1272.1613606961470745461
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Feb 2021 16:09:23 -0800
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id SJEO13715A;
	Thu, 18 Feb 2021 09:04:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZZJvAMqlGN3XBjUuTVAQW5BONPG+7r14rdmT5yYHpivttd69IaTN1Ul095/xDgYNsQ3QFuosAOI35cKoLfn++CzmONuLZlWt0I7k3Wosyg0bDIPHH5JmtcOHo1p4pRRXK7QHp7eTZJYFN6MAu6VXhfauyFU5FIg6M3HLgri/Z9t7SDLbL0wBirPjqoaq1zoN/jJAOolu6bNzMu/NZs3Ippa6WTU+hclDVla95inKTTpgB/+TVuiuovvkhwudaKVYvE33IwBaQLrxdWwUP13UbHQYERecR7m79TEmrmOIIzM/6DT/eB4Y1j7IJ8Btn7cKMUT44wTS2cjWdtWTR3XJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dueGVIiHngZ4HWW9wUc/xIp3uAIuqN+dUd6hQRubQg4=;
 b=Dj+1OE+IxNzv2f3N87NnBypTSS8UjTv+ytz+5fVrdAXzgFU67qUF25AkeXP0ezUMMlRd0fIKTmpUr3Dio5sDVwKR/eRyrfISYtuBEuSd+5lvOJq684e8na8IZDQ2TjLRzSZwuGkKSgsu7HqGnajB+n/lWNIizBOSDqUD0o0WiHfdqs2fCHXZEYByrK2OLJ839WNkM1ZZ1CpGiomjXut4HArAq+HDvprHjl1BALgR5zjzg0LQpYSIEp07riYtNKztOqc32wLAmL2CHo3LT3Dp1xa+rcW4nua26+4akJlGnJSQH+oHpqreuyKmoux0OgJA+sg6gnh8oFl4JDV99LV5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB3824.jpnprd01.prod.outlook.com (2603:1096:404:c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.30; Thu, 18 Feb
 2021 00:04:06 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3846.038; Thu, 18 Feb 2021
 00:04:06 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcFiYaTDs3nKKSoS2K7Xguob2rvhg==
Date: Thu, 18 Feb 2021 09:09:16 +0900
Message-ID: 
 <TY2PR01MB49721F716203EDF622E53CD9A0859@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86dacd98-c57e-4445-70d9-08d8d3a0b528
x-ms-traffictypediagnostic: TYAPR01MB3824:
x-microsoft-antispam-prvs: 
 <TYAPR01MB3824BE65C626F95D72228805A0859@TYAPR01MB3824.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 ap3v0lhAAb5/pyS76GogJ6JqwxjU5l/QeRjXQ5Clr4PvsPWox/A71fkUjNDwG4QMX5MrDuob8Y3cUszgU+sDmv96ZE7mTliRn5WZURpRmOBcDIZa8KdBqUPoyWcHyU8Z6rpoPIpcA81+usYyzsBfZWBJKL0wyI/lAkXaN/Jc2NHad2yZnzAFjDp6QhOVg7ZgDJJJV4HF9ozOfyCuC0TolHgFGcwSY1pRKLiOi5Sk1QzBnkdVHQ57dln/83XxXrtlHRuMg/7CXodPgP0I7waHMirBf+v3R0qjspPI7MYLGDursI3P/enD0NQ1zkcIFn0ishqOMerai6xWLjj2fh9Bv3CA95Hn9sxnHDPUXBVNl/yBSwsLsm2xrp+bNXDzakVuaMnXDgJPB8M4AQsDvnyWrctP/vQpmu8hlfj/E5gxfiMygp3uCURwiDY1SFfJLgcPVOUadwF+rCqoeTFuklXrYhG1BNkVE5ot/o0E7K/pbjWiVnEaYoA0Z8KgBYKlsjnmoyPs/9I/LbCNAJJ9+l7I6hMP5tB971vQ5B59umZ+YAD177vq6ot44fU1WSZcsLuV5mdrHbMXlfu4G7Qz5VlKPqYbtZsO06afvmPlt3DKz5A=
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?bEN3VktXeXFHZkxTeXJ6bm1EcTZuV1VGZFg1R21tTkhUTkNCL2RkSk5y?=
 =?iso-2022-jp?B?SE5jTkVRaFVlT3pSY2k5dWJFUFhFS3pCeWVCaWxlVmlOeTJjRk5HUlJ6?=
 =?iso-2022-jp?B?VUVXYWs5aUJQUVFOZlIzKzc3aklMNVBhdTl6b2kybEFpSDFvem53WSs2?=
 =?iso-2022-jp?B?KzNmWDg4dGRndGNKOEE4aUFBQUVuZkJKMkVSYXBCRm1nK0l2RmFLR0ox?=
 =?iso-2022-jp?B?UUVHTHV6KzhXVTgrUzJPdXVMTFc4alljRGxWMTF4UEw5UkEvT3pJMU95?=
 =?iso-2022-jp?B?VHgxN2g1aTN3RHBUNjRPaUFkWUdSTW4vanp4T05jTklydFFGUWxJMmhW?=
 =?iso-2022-jp?B?bW1pVnJBZm5tNjNHNVdhbEZTT1JSUzcycFQrRFRsSlBTYXNYRVhyelUr?=
 =?iso-2022-jp?B?YWhtWUpOOXZHVnJZZStORWYrMkF0OUMwRFoybGdFVllKTjdEUmZNMVpx?=
 =?iso-2022-jp?B?VW9KemVmYlJ6d1VtV2h3MGF1aXdpajZmMUFyZ3hmdXNTVzIyRE11bTJW?=
 =?iso-2022-jp?B?czVnZ25ESDNsdHp4WjJ2TUFpUi9JZU5nWkNXUDMrdllrbFZOd1FDdjFU?=
 =?iso-2022-jp?B?RUxSQTV5bEt1NTVpUHl4Q0pVYnVOelViODgrTmdTdWh3cU56UVB2eW85?=
 =?iso-2022-jp?B?WEc2ZWFWTWxWSHdMVWJUZlV6NUNLaVJCSzhZT1JLOUtxNDROSE45TGlx?=
 =?iso-2022-jp?B?UFd3RloyajF2YkxJdUJpMEp3eU51YjJmSXh1bjBEY2FnYzlqZnNCaTZM?=
 =?iso-2022-jp?B?SFhlaVQySzhwallneU5GYitDN0thREw0Yk5vOXBNRzRRNFU3RTRwYW5D?=
 =?iso-2022-jp?B?Z3d6TUo0R3JtUEJ2ZTZvc1hQd0I0T1B2NEMwY2tMR2RoZjhGZlRyTmR6?=
 =?iso-2022-jp?B?NEVNc3RQa2pZampuaWROTG1Ba1NBVm1OR3J6Tk8yeGU1Z3JmTGpVR3VS?=
 =?iso-2022-jp?B?bHhLNEZZMFJjZzR6enpMb1lEWnFYTElzN2dSajRMOUx3d1ZCYm9OWXAv?=
 =?iso-2022-jp?B?ZU1oekpGbHpOaXdqL2JpSkhUTGdZU3VhUVRZZTYrRldkM0xDVnlsbGVR?=
 =?iso-2022-jp?B?S3FQai9acTFndEN5NDUrbVFTV1QrY3ljVWFaNDYveDNPWVFrM3B6MEg5?=
 =?iso-2022-jp?B?SENWdVB5VUhSbEF5bXBhaFFvV3RKVkNsTU1tNGpaV3NzazcwbERPMzhE?=
 =?iso-2022-jp?B?ekFTVktuUk5OejBpYVVUWjBoLzV6Qm5oQWdHR1RSaGFxcE5aQTVhWHpK?=
 =?iso-2022-jp?B?VVZtTFlUdFBCWmRXcmtOYTd6RFdOQnpORUdDb2IxRTN6YWFuRHdWS1RN?=
 =?iso-2022-jp?B?TG82SWxhZ0wzdVFSYzErYkRaTkJ5R01NcDlra0dNamRza3cyekIrT1Vu?=
 =?iso-2022-jp?B?UW52YlV5Y3J2dDgxVDlWTzF3K3hlYjcwbHJHU0JWOUJVMkJCNzBCQ0k4?=
 =?iso-2022-jp?B?eXpaSnZSWEIxQkhBREJPT1VuVEVqaUxDTSszbTFJTkM2SUltM21GazUv?=
 =?iso-2022-jp?B?SFVJMDZSZ1BBSCtYN256Zk1uUDZaaXBLTjQ2WHA3enRVYlk3UVhlcVBu?=
 =?iso-2022-jp?B?dm1vUHRrck03YnFMTDF2WWcvRFNIZ3BaU3VidzZOU2UxSkwzSXMzVTg3?=
 =?iso-2022-jp?B?Slo1Z0NWZHNRU2tQUDZXY1dvejBwR1BQWFcrNEgvV3p0bjIvSVVuaW1h?=
 =?iso-2022-jp?B?VkNJYUc4clJZa3hzY3Y0WUtwK1cwZnN3d1BYbkF6VUJpTk9laG1abHRs?=
 =?iso-2022-jp?B?QUttMmZaNE1OYzNBcjJGbU5oeFdZSXlUSjlPUFhXaVVIR1l2Q2pVMStZ?=
 =?iso-2022-jp?B?SW1aSzRyME5EMHdZN0xJUk1CNDhLNCtZR3lyRkR3VkIvK2pDR2hsOG1K?=
 =?iso-2022-jp?B?Mmhsc3hxMGlLd2QvSXZkMmw3SllwWDhyU0VCaUJUZnh5V2dNQkpVa2Vj?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86dacd98-c57e-4445-70d9-08d8d3a0b528
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 00:04:05.4533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jC6TR1CIcQBDNNFVo+Ufw3XR540EFOeAWvCkCd87pL9VfhWD6bnDvPbAkUsbYsNsQM3mD4Nj3FiM2xiHcjyft1WytJCSE4adY9dX1zJjtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3824
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UhGwlD2AxzPwXxeCkKjyHDrDx4520388AA=
Content-Type: multipart/mixed; boundary="eIV5kXqLwONJr2jyoEhF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613606964;
 bh=0RMqz1HSqMX+Qm9YBYZZWQjI+urltOQ+oybuW9/Tn0M=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=tY1jcLCTtWmbP0i5teB4vBrhjLjGIaeOq0yMOs7tXX78YpOidBhVagyp1HZjEsLzfiy
 N/BWhV5ukN5XvAWtXShTvvfb7pMnbQNGfXfUuKayKSV+bf7/Xer3cUMjiZbpBcCs+wU+m
 IBclitiJw7XgU55tSLBcD3J8zyivVpkfgT8=

--eIV5kXqLwONJr2jyoEhF
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D2&day=3D18&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/02/cip.2021-02-11-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] - H=
itachi-team
  4. Track the CVE-2021-3347 patch status - Kernel Team

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

--eIV5kXqLwONJr2jyoEhF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6180): https://lists.cip-project.org/g/cip-dev/message=
/6180
Mute This Topic: https://lists.cip-project.org/mt/80718652/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--eIV5kXqLwONJr2jyoEhF--
