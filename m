Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3B5C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:08:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.8568.1742479734059062931
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 07:08:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=eiNmfk+O;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key3.smx;t=1742479732;x=1743689332;bh=IJoiG9VBkXOiUka/skMeMsztr37fusg/oWQKJe4
	wkso=;b=eiNmfk+ObR18baDERXipWOjXoLWCeEkFs7bKKnFhlO0w5G0KPX2vnJRA6qh4QSEYOwM4v
	X1ue41WkMVad2BlMpDoFPDpT5crNgXif5/oct+jGL2UusQ4Osa2O7Db5mwbLQyF359HFNpuTjQzBG
	g0dU/Al5rw7KnjISyGa/rPDkNHGE+ju8K8HSVjpB0gq230FWo7y/bpi1GgnatN8bFpJ9kDmrY0ZYx
	JGApH5dW6fruaMfXGHT2vxJ1hK6Ee5fPSJOfGbErZgAOx4M+azNtSmVhJ8lVs8E2Oy61B7W9jj02j
	V9jmsykTRYjqfPP3veiZHmKJI8/mnRoSJYJI9TFKQQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 52KE8plR2204754; Thu, 20 Mar 2025 23:08:52 +0900
X-Iguazu-Qid: 2yAbj3N9YinESOhE4e
X-Iguazu-QSIG: v=2; s=0; t=1742479731; q=2yAbj3N9YinESOhE4e; m=dhsgDlsbMt/bpW2TxyaY5FK2mjFSzt31wxuYrfQ+J3Y=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 52KE8ocV719861
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 23:08:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4qIn3Mo0W6r/sGZUxV9+FMM+fr2d30QnL2dwk3kQlQPcNkByDfqapoRk1Ua7wiirrBtGJiaNMDBmNIKdIWoVkiQG3a2pCQPddCHevqllvpJcfxpN6leQTqb88iqYTCBEZzDx5V8iGIPZVuneXb0QxY8k82oQ/UgSAklJngiwaJ3BQ2iG7fvqXZy5MsER+sPBYs63sxl5HiSQ+jhML3ZgZDNfaoKyItVYZto10EErFRWS5dGX8cfQit498g4Nq2eOcd6jaXMBLajnW6MZ76k5gkQxaOA0f7w/2SAgi7p1TPi+2qIh0Sfs3bxJJUdK/AvelCjxFMdxmi9KV7aoKWwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51mBcFZDIMmJWB0st8cnZDcFYKiLmy/JjH2p0IvK0eA=;
 b=lJkaDWnMng4M4+0LDND0CZsCS96qdyujnQYRPapuWjAVjirUd7E7reqRl8bPsWOTMgirczCId44SSC9ItoDpf5ZFzjsUtkTMjC9pjtuXCNS0AtP/AhX+8rrvPQwB8+OZuEfjtpCOSp93C6gT9G71I58WjHL+SFXmsEmfgVKT+Zn9C9d5+CEkUzGIEA0NJvtvw5WrDnq6RgDSVjGKQ+rqdhwD/83rCd525pqKq54yMrUQn1Kx7lLvCAoVD1q5fDMqR1dFtvxAOmMuXznUnZ+tqCgOLbLZpoUujkJO6gZRDTQnikM6NxhQLtzCSt7FFHHzJMeCCq1VVBRqO7IO0m9isA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Subject: RE: [cip-dev] Script sharing
Thread-Topic: [cip-dev] Script sharing
Thread-Index: AQHblBWy9JITESn130aC+n2xtD+4jLN8Ghmw
Date: Thu, 20 Mar 2025 14:08:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C22638256794EDCA757792D82@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <Z9LTIqIVKZnqQzZw@duo.ucw.cz>
In-Reply-To: <Z9LTIqIVKZnqQzZw@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB12766:EE_
x-ms-office365-filtering-correlation-id: 6c5dba4f-9305-4cd8-ae72-08dd67b8bbf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|13003099007|7053199007|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bkdjbHVpZFZhaksxSmJKb3k4MUZsUmdhQ3h1THdtQll5RWtyTzN6YzF5?=
 =?iso-2022-jp?B?MVNtbnB0eXhzbzhrTkt5TWFqNmhqNytrTkYrbzVzSld2S3ZQRUI0eHRk?=
 =?iso-2022-jp?B?ZjU0YzNEeURhL2lLZlUxcTFQL3NYWXBRc1V2eFd2YmVUcGRQYnRPY3B4?=
 =?iso-2022-jp?B?dDR1bkEwYjJ3aFNMbTJtSnI0emJmakwweUFjdERDTGxrYktvNjhtMzJC?=
 =?iso-2022-jp?B?NytCRVY0a1JnS216cUYwcTZ2L2Q0SkdxTVNJMVY0WE1ETlBKTHBCcnpz?=
 =?iso-2022-jp?B?OE94US9td012MjVpbmw1NGxsVk16dHQwcUN0Q1BrNUMyOUdub0QzeUll?=
 =?iso-2022-jp?B?d3FHdTZ5ZmpDUGhQU0xKM0VxS3NXbGdkZ2JkZ25wb1U2R2c4VWRYcGpR?=
 =?iso-2022-jp?B?ejhLOFJuV1FybWNtWlZXQmZCbU1UcVJTYy8vWnJPakx2K1JvUkxLQlpi?=
 =?iso-2022-jp?B?ZDVJOGwyTHpnQlEydENGOGRsWHd3QURFc2NRZ3lSVDhhSzl3VlRLVTJq?=
 =?iso-2022-jp?B?Nmt4SUlQSEowd1pxTVpIbk80cGJENFFWY1R6QjBwc05vdWM3b2tiOFRG?=
 =?iso-2022-jp?B?RU1JMEx3R29rYlJkeGR4aFU3WmJjcEdFMjljZE5URDNoZXNuZktEUDJQ?=
 =?iso-2022-jp?B?RVF3cXpjSUhCUS8wTlhSM1dHbDFQS0NtUTFJbEd0NG1GQ0FiYzhIeE1h?=
 =?iso-2022-jp?B?NGNXNXlKT3JaWDJMN1JDQWtUQVY4MW41WDIyM0IwNkdYU0hRd0lpUnZv?=
 =?iso-2022-jp?B?SnNKeVBFWHprSVVEUS9scVgrWVB4Uml6dDJOMVRmRm5tYjJEdFpENTFT?=
 =?iso-2022-jp?B?elUwOG5sVFd2anlna1RKMjZ2SUloR3Z0Si94d29tQ3VXOWtadkZVR2Zm?=
 =?iso-2022-jp?B?MjBVN3lXVk9YZFUybEZ4V2JCSDVncktJdXZ3cCtGLzBleVN2NzBXSFYx?=
 =?iso-2022-jp?B?SlhLRDJpejBkQjJ1OGxLRHEzUE9VcWo1Yy9SckJsTXUxeVp5ZjVtb3VT?=
 =?iso-2022-jp?B?dUxoak1yNTI0RytZUTNjeXd1dG41UGZkTU5kTHo2d2JZdy9Sb3ByRjdn?=
 =?iso-2022-jp?B?NnNVditBZDRaVlZvN0NUcXVhck5qbGdHRWlFUEx3aHU4VThIV1V4SDVR?=
 =?iso-2022-jp?B?KzlSTzFmdTdVdmM0aHFpZHpXREFpbXRvYncwSEd4d0hNN09pNVV0YklU?=
 =?iso-2022-jp?B?S0xmV1lwQURsd2tialdBN0xVYnVXMHBFM2hNbkpUYUltMm13UlZOMyt6?=
 =?iso-2022-jp?B?ckRwVVFCcWZYQ2JmRnd0OVp4dmVhTlhaUnIwTjltUXNBQmJxQzVML3ow?=
 =?iso-2022-jp?B?dkQ0TEFiOEFvOU1RSWZhdUNEcjhrSjIvZDUxWWdjQmEzYUdaWkpZdkhX?=
 =?iso-2022-jp?B?YUhFKzI2V1RDblRldFA4RDNSc2llRVEwOW1WZ2V4LzlHNTh3Q3dJZ3Fx?=
 =?iso-2022-jp?B?RGpUSHg3bmJYQ0FRMG9qbGJnUmxteCtMQ0hEZ3B2Y25QQjZyYXZZYkFh?=
 =?iso-2022-jp?B?bCtTb2doOUw4NTdXSllTT2FoQmZnS1NNakkvcUQ4T1RtZVRVOWtkM0lU?=
 =?iso-2022-jp?B?L1dnZVBDRmZmRk96dzBMVG54SEZzUW9hK2Y4bmZabXZvRTdBSzdIckNp?=
 =?iso-2022-jp?B?d29CNVhYb2doZFdmak9Hb283QklDeHdIbUM4SnZPaGMwaGVFZFM4d1l6?=
 =?iso-2022-jp?B?YTdTc0FhUmJoUm80Qm9mdEdvWW9tdm1wWGYvOHhmenhJSmcxdUVwbkVU?=
 =?iso-2022-jp?B?NDlyM3BWZXZRakZFSG91QzVVa3B2YVZkTHFRV3F5Y0Eyb0Fuc1FlWEto?=
 =?iso-2022-jp?B?R1pyQnZIMlB3QVZMb2hxWngzMXovSkNDSzg0NHUzZ2E0a1kwcEYvK2lR?=
 =?iso-2022-jp?B?U1Q2bjVmZU5UMHRjQ0tZUnZLVGxKRlRiWlRhNGFEV1V3RkNBcFJUQnJ5?=
 =?iso-2022-jp?B?NTNGL0ppUE9YektDT0dvakFraGNzbzJNdzJtcE5oRUtFRXRDbzdYZXdD?=
 =?iso-2022-jp?B?RlM2ZDNsWStBQUd5clFTeEx1eVhBUFFUSExsbXIrSGdiMVBhQnZGRUlC?=
 =?iso-2022-jp?B?NE1xRUd3c3BuTnFHUGxqVDZGYzhmNEk9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(13003099007)(7053199007)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dFVJU245Yi9GTzhRRG05aFBqd2Y0bm9kSllDNkJOeG14QTRnYnlJVjRm?=
 =?iso-2022-jp?B?VUNyRmJ0UTlkWmZKK3N2ZHRVYk9RTnc4dUYzUmJmN0tYenJUeWNTWEpy?=
 =?iso-2022-jp?B?V0xaTG5Qd0R4UDgxOHhjK1A3R0VpRk41M1B4M0xodUg5NmZlVUtwbkRO?=
 =?iso-2022-jp?B?cDQ1cXR1alovV01wYjIrQjhjZlR5emdHVWxpTDE2NjE4dFUyMXpWNE1l?=
 =?iso-2022-jp?B?eDVUWXR0ZDNvQzM1RzFua0R0a09QdzdVa2Q4S2xJVWpacnZ6OTc0eTJU?=
 =?iso-2022-jp?B?MCtNWFRDMUpLclBuTjFLejM5NHB3azRNVEFHQ0ZJZ2dRcDVNdDJRdHox?=
 =?iso-2022-jp?B?WjJMMTBQYnNjZzlMSTJYeHpSMEwzbWRCUXpRbFUvT1MraWRXRHluU3l5?=
 =?iso-2022-jp?B?M1JkaFkyZUxLWnYvYlhpK0ZMQ3R5U2hjSUl3R3cxY0phTHpJSExGbDZH?=
 =?iso-2022-jp?B?TjJNRTdKQTJyV1lQZU5Hb3A1Z1QreVNoTUVLckhrbmtNeElTbHA5T3Nt?=
 =?iso-2022-jp?B?Q1RvZGkvWlllZnNXSFBINDhKWmt1ZVlSVVJxT0szVDU4UFVQQSsyRDRY?=
 =?iso-2022-jp?B?R2Zkb2p0b2ZKVTVKOE9EeERVNEcwNHNDOTlCSmg4V1JxVmVJd1h0TTdN?=
 =?iso-2022-jp?B?dzFQSVNhWlhlR2Q2NTlCZHY4anZTU1pTRjJCNWlJc2FXdHY4WkFWVlVu?=
 =?iso-2022-jp?B?cHNYb2FTZ3FRRlA1R2NuNjJUY0dmenlYYjV3K3MyUjlHSUMrRVErQlA3?=
 =?iso-2022-jp?B?N1lLcDQyS0ZaMnRQNVFFRFFvVkxIRXFHSEhrQmhNZEVNazExMjhDam02?=
 =?iso-2022-jp?B?QXhJNzVhSytNNSt0ZHJVbk1uTkJKYWpLRDE2UXlQUzFubm5JbUZSNFZv?=
 =?iso-2022-jp?B?YUxhZE1xcEl5TEhXUWlEMWZVOHJMYmhHQ2xKdjE3YW0rVXR5bExPMnlw?=
 =?iso-2022-jp?B?b1FDQ21qU1BXRDF0bXRad2o0VXJRWWQ3R25Genp0WnJjd3VRdHRaYnVp?=
 =?iso-2022-jp?B?dE8zWEJ4bVNJQnd6MWlGT3dtclBZZlpDRUJxdTBQY0tUcFp1TDdocm5w?=
 =?iso-2022-jp?B?VnNEMmsra0FIWXg3OFpDTkFTcVZmSHFHa0J0VjdxU0llZ2duejJ0ejE3?=
 =?iso-2022-jp?B?ejRwM3QyWW1paWdvUjlZbGFaY2Y1dWtILzBQMFYweldMOC9DdGZBQ3Mv?=
 =?iso-2022-jp?B?R0laNEtlbGt0SGhsRmRzTVZrSVFMUHJJNy9wOXEwcGErTkRob2NYUlhR?=
 =?iso-2022-jp?B?dkE5Rmx5M1RNaUtOTGd3c2ZUREZVQTFMSGZOYXlTbHJsZXh1SVRXMUFl?=
 =?iso-2022-jp?B?alhGbkFnM0RpOUcyTGpJUW9LcGo1dm02MzN0SkZPRjNoMUdIVlFTTk51?=
 =?iso-2022-jp?B?dHNIVU1QeUpnbTgwTG9IeEo5c0xHZS85Y0QwczdQM2s1Z01QVDF5N3pP?=
 =?iso-2022-jp?B?Y2pQQXdNWEllaVRNZUJoZDh4RURiN2tlZEtpeUo4Lzl0bWJIcWRBRW5a?=
 =?iso-2022-jp?B?aVhIbkN6RE1CcW9zcnErdGp0Wk8rR1ArUkt1Y3MyRmFhQXNYOENmTWV2?=
 =?iso-2022-jp?B?YWVib3ZKY3NwRnFjcXNEVW1kTXNvR3B3OG9ZN2tuU2Z6ODNudnlxZDRU?=
 =?iso-2022-jp?B?MjVGZHV3WVhBVlhkMTJyeHpRNGF6S3VsSmw3bjdhcFpMMm5zTURYcWRv?=
 =?iso-2022-jp?B?WEE1NnBvTmpkZitUNDlMMWFCMUhRQndQUTR2aFhVNzF2NVJxOHR5MlVI?=
 =?iso-2022-jp?B?MGRPNnF5MnBKT3owcVQ0eUV2b2NvM2lpMVU0V1k0RlFsWEVCNXZtV3Fm?=
 =?iso-2022-jp?B?WENySDIwenJ1NlduaVA2RFNuTzVlVWx3YUZIRWV2TnRRdkowR2YxQm8v?=
 =?iso-2022-jp?B?UWNxYmRUOVh3RWpyR2t1T0h0ZUEwZWMyaDQ5NHVEZGpxSjdFc09CRVVq?=
 =?iso-2022-jp?B?M2hGb3I4dUM4aG5ZamYrejN4M29iOUxsYmxHOHZtQzBQNTQ0WWNPRkk2?=
 =?iso-2022-jp?B?L2NzQUMwUmVrVG5KZVdpejMzRTRkOFJOenAzdFVIYnhHUzRuQ0hrYTRr?=
 =?iso-2022-jp?B?TDIyRmVJeUFqQ3k5WVV6YjFTbUkydUEvWFB2MjBVV28yOTRQNmNESEM4?=
 =?iso-2022-jp?B?M0lIbWsrejRCcUxWdFZ3THNaZG14ZVY4dEwzSnF3UEVCN1U1emNwMnpz?=
 =?iso-2022-jp?B?Tlo0WFZLeno0bFNRRGNDYVR1TThVaU9nSkVCazF4Y2djL0FUWHJJY2JK?=
 =?iso-2022-jp?B?dGVKTmE5YzRlc25KbUdDOXlUTXJibjJiL3BTZnR3cTlPUHk0d2JnUXZt?=
 =?iso-2022-jp?B?V1Vla2JEcEMzSk5xTFlyMDFsN3MrUEd2RWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5dba4f-9305-4cd8-ae72-08dd67b8bbf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 14:08:48.1387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGvLccuEl9BDfOC1iwgvIsfyi5OzD0rtulV0OYDOkf133yFJKAUa/LyG69Jf1LEWsw9nFUiQJWocozQ7YPlt8/aJaLg5MV+A0qTH/ssGSKYj1pi95xyR+dWRRRQNLoR/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12766
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 14:08:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18299

Hi all,

I share my scripts via gitlab [0].

- Create a CIP kernel release tag:
  cip-bump-local-version
- Create a CIP kernel release tag for rebase:
  cip-bump-local-version-rebase
- Creating a kernel archive:
  cip-archive-signer
- Create a release mail:
  create-release-mail

Best regards,
  Nobuhiro

[0]: https://gitlab.com/iwamatsu/cip-kernel-tools

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Thursday, March 13, 2025 9:44 PM
> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org
> Subject: [cip-dev] Script sharing
>=20
> Hi!
>=20
> So... some of the polished scripts are in
> git@gitlab.com:cip-project/cip-kernel/lts-commit-list.git repository, dir=
ectory
> bin.
>=20
> But I guess there are some not-so polished script.
>=20
> This is what I'm using for testing, called testhash. Yeah, especially tes=
ting
> mainline trees is tricky, and results need to be checked in web browser. =
Better
> solution would be welcome.
>=20
> #!/bin/bash
> # git checkout -b delme-613
> # git diff ..linux-4.4.y-cip -- .gitlab-ci.yml | git apply # git add -f .=
gitlab-ci.yml #
> git commit -m 'add needed testing'
>=20
> # git push -f git@gitlab.com:cip-project/cip-kernel/linux-cip.git
> 8a522bf2d4f788306443d36b26b54f0aedcdfdbe:refs/heads/ci/pavel/linux-4.4.
> y-cip-rt
>=20
> RT=3Dlinux-test
> if [ "a$1" =3D=3D "art" ]; then
>     echo Requested rt test
>     RT=3Dlinux-6.1.y-cip-rt
>     shift
> fi
>=20
> if [ "a$1" !=3D "a" ]; then
>     echo
> https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/$RT
>     git push -f git@gitlab.com:cip-project/cip-kernel/linux-cip.git
> $1:refs/heads/ci/pavel/$RT
>=20
>     #
> https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-r=
c
>     #git push -f git@gitlab.com:cip-project/cip-kernel/linux-cip.git
> $1:ci/pavel/linux-rc else
>     echo Need a hash
> fi
>=20
> And these are notes designed for copy-pasting I'm using to do -rt release=
s.
> (Normal releases are slightly easier). I guess I can put it into bin/ dir=
ectory, too,
> but it would be tricky to turn it into polished script.
>=20
> Best regards,
> 								Pavel
>=20
>=20
> BR=3DX.X
>=20
> ~/cip/k
> git remote update
> git log rt/v$BR-rt -- localversion-rt
> git log origin/linux-$BR.y-cip -- localversion-cip
>=20
> V=3D$VB-$CIP-$CRT
> echo "$V ($RT) branch $BR"
>=20
> # base version
> git checkout linux-$BR.y-cip-rt
> git merge ...
> # rt verse potrebuji git rm localversion-rt; git commit # increase versio=
n in
> localversion-cip-rt .
> git add localversion-cip-rt
> echo -$CRT `cat localversion-cip-rt` -$CIP  `cat localversion-cip` git co=
mmit
> -m "Mark this as $V ($RT) release." -m '' -m 'Signed-off-by: Pavel Machek
> <pavel@denx.de>' localversion-cip-rt ./testhash ...
>=20
> # https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/linux-4.19.y-c=
ip-rt
>=20
> git checkout origin/linux-$BR.y-cip-rebase # Pokud potrebuju starsi strom=
, lze
> git checkout v4.19.280-cip96-rebase git checkout -b b$V-rebase git log...
> # Pokud je stejny base pro rt a cip...
> git rebase -i v$VB --onto v$VB-$RT
> # 4.4: cca 937 patchu.
> # 4.19: cca 965 patchu.
> # 5.10: cca 1140 patchu.
> # 6.1: cca 505 patchu.
> # Prvni by mel byt "CIP: Add a number to the version suffix".
> git diff ..linux-$BR.y-cip-rt
> git diff ..linux-$BR.y-cip-rt | git apply git rm localversion-rt; git add
> localversion-cip-rt git commit -m "Mark this as $V ($RT) (-rebase) releas=
e."
> -m '' -m 'Signed-off-by: Pavel Machek <pavel@denx.de>'
>=20
> # v4.19.50-cip3-rt2-rebase
> # v4.19.72-cip10-rt3 2c7eef0cfbb904f96032adea865661799a912e04
> git checkout b$V-rebase
> git tag -s v$V-rebase -m "Signing -cip-rt release" -u 95DBFAF2 git push -=
f
> --follow-tags origin b$V-rebase:linux-$BR.y-cip-rt-rebase
>=20
> git checkout linux-$BR.y-cip-rt
> git tag -s v$V -m "Signing -cip-rt release" -u 95DBFAF2 git push --follow=
-tags
>=20
> # It is neccessary to have "cip rt" checked out.
> git checkout linux-$BR.y-cip-rt
> ../bin/git-archive-signer
>=20
> dmutt -n
> m jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
> Chris.Paterson2@renesas.com
> Subject: [ANNOUNCE] v
>=20
> Hi!
>=20
> New realtime trees should be available at kernel.org.
>=20
> Trees are available at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-6.1.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-6.1.y-cip-rt-rebase
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-5.10.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-5.10.y-cip-rt-rebase
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-4.19.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-4.19.y-cip-rt-rebase
>=20
> And their content should be identical. There are also tar archives, at:
>=20
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>=20
> Best regards,
> 								Pavel
>=20
>=20
>=20
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


