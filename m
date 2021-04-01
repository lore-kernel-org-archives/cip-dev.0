Return-Path: <SRS0=vrla=I6=lists.cip-project.org=bounce+64572+6337+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FAEC433B4
	for <cip-dev@archiver.kernel.org>; Thu,  1 Apr 2021 00:56:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3BD610CA
	for <cip-dev@archiver.kernel.org>; Thu,  1 Apr 2021 00:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3BD610CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6337+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mlf1YY4521723xWHgo1GXKr6; Wed, 31 Mar 2021 17:56:06 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.51])
 by mx.groups.io with SMTP id smtpd.web08.1178.1617238563197823235
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Mar 2021 17:56:05 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id BJx531945A;
	Thu,  1 Apr 2021 09:49:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpwndZnsGxNeuopM3v8tWIJmOVL5Z/Aj/0Ewnhwikg1Ik+vScF3I7EzyYiaKjH3jjyVXapLQ04ycU1Zz9pt8aLIOAg8vgmhoslWEAG6opwbsg/+TH4ale0YAdH5QT7mX2+B4TBz4fmaIJEGGGZ3criUKJm7ErGYS6kba/s2WokDfJamINR9QoCYvPL44uLGstgo1f1O2bfmp0IM1h+A9iQyumr8BOqroHy0J0bHNdNac7iOTy9DkRjgZWTXJbTndbJLSgZhehxOwQB9wX9VVLUOrWSfBPKy5JGeahfGQ8QLT/c7BrDIbHv9g5GbSyxlhA248R1SAyeGFxsGMICBQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg20h7wUCsMmaYwlYy8n2zbF/3ojUylLpZVVSzjgA9w=;
 b=gUj5kesgca5gvkkdzh2E6OevIihIy/JxOo3LGa7oF1yy3d/FABUPaljuC7rYY2td7T0+ty+Wf6XQ0Y7BIiKBt0wWC56t0RBvXadPZTnWMKzSr53fMsOwYfCE+qyByrZK9MtDYU93B41GEImNmcX91y8CfuTjH4etSvRu3cB1cXMd9zrHrum8mTN3/tTrpGqX2HyRmA7JUYs83tT4Bs7HA1qaw5A2ALCeR3oISGN+huxH98fZtIqiV2Z6BWm0rr5Ki3AIy/KQCbxO6Z/zJf4Q21nJUw1TbhGuyIZ7+IluYaKqIBOONF+kZ1niU6xm4fcl5SGqve7KPeCXpZhkGXkk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYBPR01MB5344.jpnprd01.prod.outlook.com (2603:1096:404:802f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 1 Apr
 2021 00:49:52 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::a991:357f:8cba:8599]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::a991:357f:8cba:8599%4]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 00:49:52 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcmkOle/HMyZhEWSAiLUReixNPKqg==
Date: Thu,  1 Apr 2021 09:56:00 +0900
Message-ID: 
 <TY2PR01MB4972D4ABA58C9BC48CDEDBB9A07B9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df892538-e0bb-4437-13cb-08d8f4a80f70
x-ms-traffictypediagnostic: TYBPR01MB5344:
x-microsoft-antispam-prvs: 
 <TYBPR01MB5344D471193457A95E97322EA07B9@TYBPR01MB5344.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 vW0KKtoiEga1IJMnRLBcVtU9hI5km2tXYsMnN36G3wJ4ig3dQXpsBgAqWeo0XaRpl4rFMsWvNCpcgzsWrYFqg/g+TqctZwJwXi7VqDSbHpkAlhQQy0ertm1qPhl3u8OtmvUgsdNO2TbdKdhZ+gbMZK90bCr3L1OTtPigdVW1LatoLQqOF/aeFy2+lYLSdNvXrj/OFzui8aHAdbHwWxXCEMDGRBfd3+nPYbUV8Yrg3UIFUOAk0Ie8aQMOeYakVyr9bQXfBGighetROekT0KODKrHmnnaIcD1LBm2DLcazTOlPj1963Lhpo2T2Dd66x85Bv3Q1QtAaqTWKXmqWNb8MsC9fF62OY0jqqfn3lYXZ6D2z8A2swnFBeBc4ZaRK7uxg4ZZTnrpDQxs7uvJsMFoU9JpkBiozdmMHlKAKrHJ1tMWrZ548hzcLYMZQNPXd0C1U/ybgqixcHXqhJL/HTrFovkaCOdn7XpHRf3xR7RbhaxZtxdlv826dmywy7JYGLkKTHgUIIv20HBO0/gx6e+VmdiDZC6kwwBNHKYeXUD8uS5pQosiy6XAxQgQ49ZWYvI7XtLsozOORmxDphzo7OU8BA6tHDBYvAqg+Ozlv9gCXzKVrBRvOQQPAq6kT7sP+YIR3525/uAqz1dPRWAiKeorXTltpIY6S/TNhOAtLZMlIc8ErksWG6aJHjWIpBdwLl5j0ozjB6NZVZVLW+FVD7pUSOF9GfPG1Iggfe6DEn+0jE3JVhI4a3fahLIQsJBVmA/Ab
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?Rk54TFRDaUMwMGdKbDd2OEo2TXpTSWtTczQ5QmpPR2N5TTVjb1FGT0tX?=
 =?iso-2022-jp?B?NlFPT25ORnF5OUg4em9LOFNsZ1RmRVFJNWlwWk84b0Z1SXlzazhCZFJJ?=
 =?iso-2022-jp?B?RzFaWlRvS1JjQ2ZzcVExUGh1STNoV3d2U2t0ZXZyeHdZaUdIT0NSS2dD?=
 =?iso-2022-jp?B?NkgrZ3lRNjdJb3A5TnBLby9sQVZ2bGNJS0RodXdCaVRIdEpBR3NWdHJB?=
 =?iso-2022-jp?B?TzJMUjRhNWdFakwxSC9Zd0s5TGlIWGZ2MVN3NGZ4TTZ0S1Z3bFlyRUZR?=
 =?iso-2022-jp?B?U09jYWVPdVcvNTRkUXFBZVFhQ0RaQnFRRjJpTDlZOS93czhuL1d3MFhV?=
 =?iso-2022-jp?B?aHVEdzRXcWVNaWlQcDdrOGFCaFRHZm00dmJ0bGFWNzUrazJvdXd0U0N1?=
 =?iso-2022-jp?B?VjNFeVIwazNUbkhMQlFUcnJ0VWRrdzFvOUttMWhONnYrOVc4dlM2SHdN?=
 =?iso-2022-jp?B?a0QrSWI1aXNFVGtoZ09Ec2ZsZWZxMmFUczh2TDdFd1REVDJ0TzRvSFQy?=
 =?iso-2022-jp?B?R2hoN2hNdUVYL0pjemZ0Q0llY2E2UDFJT3BEOUQwQ3lmbFpsZWtFd0dZ?=
 =?iso-2022-jp?B?eVgrSm5BMCtrUUNWMHBrZ3MvUEEySXMvSkt1OUhHY1JXS3VmNjNTb0Yr?=
 =?iso-2022-jp?B?aG5FbXU5ZkJXSW5NeER1NDRtNmdzOGJ3UEtwVWNrN1hEaFdNdmlvQnhR?=
 =?iso-2022-jp?B?emJjT1o3QzJsQnVRK21Yc2tMRUZjZjBRdGlMb01xd0M4cGFwNzBqMmpa?=
 =?iso-2022-jp?B?ZzJ2NE1QcGhJOXB3MWRLdkQrTGR6MUdpQUJUb0tmUXMrSjZFTVhmN1R4?=
 =?iso-2022-jp?B?aWRnT0g0Z003bmgvMUpXbWVVS2RCM0o2d093Nk5CWWI3blRYWDJGcTIw?=
 =?iso-2022-jp?B?UlkwaHplL2s0UWZWdjdhUEpKOGppWGlwQWxrNEtDZFhYZ1lQcStKMjlm?=
 =?iso-2022-jp?B?QW15b2FRdjlRZVFwMDdJNkQwSzFCQjZZUEVweDRhcVNvMjZ4cDU1NW81?=
 =?iso-2022-jp?B?MVlHbDhKWk5QeFVaSGQ4VjBFL3dKVkNPdkR3NUI3QTZDNlUzWkRYRTRN?=
 =?iso-2022-jp?B?V3IyTGw5VmE4NTZpSzBWRnFsUnFtMktMY0pHMG85UGxndHJscHZSQ3U3?=
 =?iso-2022-jp?B?MWRUZHFRUXBydUhLK00yYmJWYWc3blVSdThHM0VieXUzakdKNlQyZFh1?=
 =?iso-2022-jp?B?cjBCQmVwSndCdHBYblVxa3A1KzdIWkJQZDNYZXVhY1pSZVh6WSttN3dQ?=
 =?iso-2022-jp?B?NmZzUk1OQlhXRVFVUEc1ajNhTzhuNVdINEZHNUE2ajdiSmUwQUZLSjJB?=
 =?iso-2022-jp?B?KytPVml2K3p1eFN2RDdVV3dvQnVEYUFDaVU2UHE2eHFvL3lDMVZDOWRj?=
 =?iso-2022-jp?B?cnFReGE5VmVxeHk5OWVQZ1ordDhIT1NhekIveHduQ1IvNTFzcXoxWnV1?=
 =?iso-2022-jp?B?eC9pemNrMUs0eitWQzlCOVoxVzFzZ0xLbENTemNyWTRYcG9TajBTNmdK?=
 =?iso-2022-jp?B?aklWUmFwTEpmOHRFdnV0Snl5Y29SZnZvMHFESlJHZnZsdUdZblBRRFh5?=
 =?iso-2022-jp?B?OUREb2h4MzRhMC81ODVOeDRSSHNKY1ZIa2YvaStBRElrWEJEUjlIb21B?=
 =?iso-2022-jp?B?YW55T0dnUVk2RXZOcWgybStWM0YzRjBZaE52MU5ySG03R0tyLzVXdUxP?=
 =?iso-2022-jp?B?cmI2aWhRNWdGSHZySEdUbjF3TmVXN3BmWjZWdFBHbWw3a1FUZWQ3TGhF?=
 =?iso-2022-jp?B?cXZ6UzBPOGppaHArWTM3NU1CU0I1dSt3TGdIaHVhdnR6YU1zYVhia3I4?=
 =?iso-2022-jp?B?MWJNcEhtaEhlR2J0Zk95THVlQlNXYkdOdlFSMlRlQk5jZi9keTFrK1pX?=
 =?iso-2022-jp?B?TkowdWdDOFF1bCtnd1ZTdXdVbmp5clZPNDRBMWZ3bzdFQ2lvRnkwclpz?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df892538-e0bb-4437-13cb-08d8f4a80f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 00:49:52.2971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngKGlMljcjk8c0dpvYUfGBoZL/bSnQwqUGrhFILetKTFukLMXUuIPA+YpI993n7zccABwRy3VpFoHH5ouioi1liMH0q5GtDW/jB15ashKNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5344
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GLXv0GOScxeGmR14yn5um1iYx4520388AA=
Content-Type: multipart/mixed; boundary="4dzXE33QACDBg4stSYVl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617238566;
 bh=Ou70FpF7d7175F6MlZFXDyPp5qyFakwDMwPKF4Ctt2I=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=WhPWZaBfukGj2sn+3CAGjTVQE7cPoA9YSzKjgMQY+TXXVY/2ZKmtbAUNpFtgbb9PCut
 g/0FpNAWD78XffL+pS+jS1NIiiuu20cmzonjb4M7d+LUNblzcsDx0d0KNw6JCUBCZuJLv
 Kb94Vs0yZShmYg081Pk7ZpIvwo61+tlf9sk=

--4dzXE33QACDBg4stSYVl
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D4&day=3D1&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/03/cip.2021-03-25-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Ask board owners(siemens_i386-rt/plathome_obsvx1) whether X.25 and flo=
ppy can be disabled - masashi910
  4. Monitor the status of CVE-2021-3444 and CVE-2021-20292 - Kernel Team


* Kernel maintenance updates
* Kernel testing
* CIP Security=20
* AOB
  1. Announcement of new reference platform - Xilinx zcu102
  2. Target boards for 5.10 and 5.10-rt

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--4dzXE33QACDBg4stSYVl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6337): https://lists.cip-project.org/g/cip-dev/message=
/6337
Mute This Topic: https://lists.cip-project.org/mt/81765627/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4dzXE33QACDBg4stSYVl--
