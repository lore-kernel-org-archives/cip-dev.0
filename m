Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722CAC83F27
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 05:54:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.15304.1752645268792293516
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 22:54:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=En61hTUl;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1752645245;x=1753854845;bh=D8
	MaKN0rfkNdscisrNnfoc89urr8gA+V3XM3SqvnlWQ=;b=En61hTUlTTyOhsZwITHWgxjxYWIKJhl4
	6pTnV+IjNgadhQ+eXV1iLS7E7gFIJ1degXPYk0HkRFf2opeqgSqNIBkCgAar/qIIFSh64LFC/r42f
	IXEFJsagI5/IVPYrk1lMZK4vct14nyvbU7NN4fWf3Ar0vMiZAfI5eNpbybgiyCzv93HYHN/WgXm5l
	ebgEn6YFQvifzv5WcJ61WapHcql12yyabzF2ISeFyyD+WkpF1c6bMtETy5GeM+d9jVvdoz1tJSvds
	fIEbPXCRQe2zQFJy0E8FegXGJhEKbXOacpnt+npFe/257Yvoe1WgGAKgxgb6toT3DbLScRA6916Mk
	Fw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 56G5s4rC025495; Wed, 16 Jul 2025 14:54:05 +0900
X-Iguazu-Qid: 2rWhBFYKMvlvNfNNjA
X-Iguazu-QSIG: v=2; s=0; t=1752645244; q=2rWhBFYKMvlvNfNNjA; m=ku8wlocpCAizSy2YiPSPoO9dh0wrOOuLzVQczebZ07w=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 56G5s2vi3516734
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 14:54:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZaBQ8dgyo4iNSGr01Ct5GfnTI24a6NaZFrr5HoPW9Es/HwxeqJ9QJBLd64z+XiqI9mJDykwgl3eK9ni2IjxtnyoYCeBmRdDx2EbPujJLTXNjdyDMQl0CcD0jOAGUn+qzsL+hb/xEvarz+lOQ9T7iuWL1+0t/rcURzA22Qo4fSVpMo/vlc0zLyY5x+PnM/EnTEV/vr8Dfr3OOfHg/Ld3+TGEP3NsVTUNxXsE2Mi47FwgUe/0tO2QfMKjPYeRiuzTKCKSC8/+ykEFmnGEfCi6pKe82xOYRkUAOYpZ4wMkJeHriZwPqHp5qKuQUfubhiQTEY2B4Wy0WUPkjb3/2JiN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3Nd/p+NzFK/+alv/bbNC1QY9wRfWtt1tA47CuyMfck=;
 b=lQKAI4nRhQK3lelYCiIApINFKEDtHWzA8J35uaTNvYoA2KJ6p37aAgYG3nyVxjRy3rpZc4I7VAnM4+OedFzDlMuS4bmzdBRLy6tYPHTQV/yM+el2thxha1SF3CVLlV8AYyq9HIL0cPWLH1Dpzljn6e9NxZl4J+nGwIpHp/vsEhTj9g1gM5+FOW1qz+izcRUqsPQgkkErp1qBQ6OBIdnfprlsHwP4JLypMXnCegl/Drvf/OKFQ6Z73thYcl+bZ256tZHjB1AxlMt5r+bjoewBBL8IikNh40dcbi5nAH8ifgnHRNBlie5f2kfMWFEemDN2T5YqIkBeH9BhLmJvlrbWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v5.10.239-cip62
Thread-Topic: [ANNOUNCE] Release v5.10.239-cip62
Thread-Index: Adv2Fbo30DCdg1JHTEWWs/Ztj7edAQ==
Date: Wed, 16 Jul 2025 05:54:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148188A4F693767026FA940D59256A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB10477:EE_
x-ms-office365-filtering-correlation-id: 341f10d5-1825-44a0-28f5-08ddc42d2990
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UE1WR05qRFRIL2tJaURiSFRYbGR1ZGpONy9JNzVHRW9QUkp1Vit6SEti?=
 =?iso-2022-jp?B?aG5lYy9mZ0o5c2FjOWluYjBFblprYnVacVo1Y2pNOFdtRHNDaWp0RjdY?=
 =?iso-2022-jp?B?UkkwQmh1VWplazRteG9xRGp0NnlXc3RUZzhmYU5JSnhWV1BHaE1EeXZM?=
 =?iso-2022-jp?B?TnUrdk5pV1crMEZjU1U5YkV0cStaM2R5aW5jQ1cwd2xHRWRLelAzOHNE?=
 =?iso-2022-jp?B?YUlPSlRWTUZneDZTMDNsSUN4cC9Pb1F0MkFvZm90d2prcTFDajI0YkZQ?=
 =?iso-2022-jp?B?SktablhKeEFVcVl0bU1FeDk4WUtBWitTTGpxR284NzVEWXhPdkNnR2Jq?=
 =?iso-2022-jp?B?enZaQ0huTnZzL0ZqZGZxc2prclZRVEtidFplRlJxVXppZDR2S2ptekI4?=
 =?iso-2022-jp?B?N0Zib1dOU05qdmtHUVJ1NEtud0F5RTlITHBFamFmdmJxdXN5Y0hGbDB6?=
 =?iso-2022-jp?B?S0c0M3VGaHBsbS9tRUlBUEhsMEVyb0dySzlQUVRQUVJNemR1MVpLV1BE?=
 =?iso-2022-jp?B?TVU5R1RjZ1FyKzZlczlsNlg0SWxIMFJTVmcyUHQ4ekxQdk9aeEpZRVl0?=
 =?iso-2022-jp?B?Q0tYeStkWHlRdUZOeWJ3MGY1ZkdOSWVhYWVaYXFDMHkxaitNODY4QjRp?=
 =?iso-2022-jp?B?YU9YQitTUXFQVUFXNnNJK3lMZDYzdElPeEllOGZUTEdrT0hYc1ArUUVx?=
 =?iso-2022-jp?B?cUZPRWp1R3B4ajV3OW1HRGxheDBTb050L0pYak5abXpTd3VyZjA1a2l5?=
 =?iso-2022-jp?B?ejF6T3pxOEQ1S3RJMGgyOFNqVW1EQUxnTlNaR0k4aUI4QTkyWFFMUkJn?=
 =?iso-2022-jp?B?S3kyV2ozVGJ0UGlXWWhQK2J3YTFZMkpXenVpVjRqRDNJb1BuWVN0TnRV?=
 =?iso-2022-jp?B?aEx2eERucUtGN0VtRUg1STNxdW4wb2h1MHA2c0xLdVc2L1RVU2tMVGVp?=
 =?iso-2022-jp?B?dzZRSlY3Rk1XTElCclo2Qm1FdlR3OWRGRWRsYWpZOW4vbmNjNnkzMUNT?=
 =?iso-2022-jp?B?VHhhMHVodkRrUzVmSGIzWHJ6aDdNbG8vY0kxd0M2R29RR0gxcjZvbnkz?=
 =?iso-2022-jp?B?VDRWbVlYMGdiNVVoYlRtWlhnTGQ2d0RUcEJ1ZjQ1TGZPMnZER0pTTTlm?=
 =?iso-2022-jp?B?UmVNemN6Q0prQ08wNnI1MXE4ZDgwQi9Uc0ZJaEV6T0t3U0t2ZHdrR2VL?=
 =?iso-2022-jp?B?UnR6QnBseHVhUDNFWWRwaE9rdFNKaWczMEdNZTdZV1YzNThpZlVkQkJO?=
 =?iso-2022-jp?B?YndCc3E5bHI3RjNGdmVGVy9zNFFDS0liOTF1K1BzY1oyYXgwZjYyNmUx?=
 =?iso-2022-jp?B?YVhObnl1eisyVURQUFp6ak1vdjV3TWNLN1JzeXd0UWR3ZVd5RXlBMnRR?=
 =?iso-2022-jp?B?cGpMdHFDeUFkVHY4MmtPWUFLdzBnUVdoTVJVTFpPWmZyM3JOLzBNR0w4?=
 =?iso-2022-jp?B?YnpsV3ZKWmtsWGdqTWQxYzlsbzZXQ3E0OXhJNzg2cHVUU011UURPSjRS?=
 =?iso-2022-jp?B?M3YzSEVRNStBUWl1Y0dTaTZ6YUYwaHZSUmgvNk1jNXZPR2gyMzJySDQ3?=
 =?iso-2022-jp?B?dmZwWXJyd2hCd25jMk8wUmlqUlcvazVrQkRaajMrd2UrWFhNVW5uUnZQ?=
 =?iso-2022-jp?B?RzBQcUhuUkVWdmhuaWovb2I5U0l5b3ErQ0NEd0lpb2pMNjh5c01PaUoz?=
 =?iso-2022-jp?B?R3FNYnREL2dDZFZqRlJuSWhkb3dJbXhuSzhxR1BRcmltU25Qd05tU1g4?=
 =?iso-2022-jp?B?RjNWMG04MERiaXFTZHQ2aW4rSmhGSTdsd1dMVGhFN1Uwa1o4R1RWcytF?=
 =?iso-2022-jp?B?eTkxN0tFL0Y1M3BFZGtuZCt1U1JYZ0psSEhOZkhaYVRNNGd5UjdJZ2x0?=
 =?iso-2022-jp?B?YlVIY2RvWk1zeGdpRHAvZ29tYmJOcDlpcjZiMG9naEpGSmg3djEzelhX?=
 =?iso-2022-jp?B?cy9LdkQrK2gzc1ZXSnY5OHJlR3p2eDhsYWlQYXBqaTVXMWEranFrUjJz?=
 =?iso-2022-jp?B?ditkZ3UzdEF4MkZ0Z2JpWVYvYTMrWXRndzNlN3hFTzNWVWZiZDhYS0Vp?=
 =?iso-2022-jp?B?N2NIcXlQc0RZNzJYM280TzBFNFJpSTdINGc1ckJzbXp2UGQ2VlJZRW5i?=
 =?iso-2022-jp?B?aFU0dllBOXQxdkxyZTFta3o2WnlLcUw0SW5PZDRZUllESEdxVmJ6dTVU?=
 =?iso-2022-jp?B?NzNFPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VHpWdlJ0cWo1bUNweTA2SWZmOE43a2o5N3JsOE9jdjJTTWp5Ymwvb1I1?=
 =?iso-2022-jp?B?eXhPVmtGUitkdmp1enllT2xiRXdrbGxIMTl3UFJqTEFpR3BYVUI2aHpa?=
 =?iso-2022-jp?B?RXA3enBvSkgzcWNYNUNtK0U4NVV2aStBSG9GRGwyeS8rZ1IxekM4WHQ0?=
 =?iso-2022-jp?B?dzdEVjJKZkE1TTBXckFZVDVBTnB2ZnFycElVbDVEdlZkdlQvNXdGVUIr?=
 =?iso-2022-jp?B?L09hV1kwUFpnVzBFd2thZWNldG5KNUZWTDFsTjdPcmZlZkNpVmlnUnZu?=
 =?iso-2022-jp?B?djNJd09EcE4zTzNRbVdGZkE4UmFqZEhwZUZ4bXFxd21iQXF1eFRqSHVM?=
 =?iso-2022-jp?B?bm5JbnhMY3NMSllsWUE0bFFNOFh3K3BnNDU2VTBuYlJHY214Z1RnWnJn?=
 =?iso-2022-jp?B?Y2diTG1GRDFMNmpRN1E4UVNGS0R5S3ZXTTNXK0lVVkszRFBjbTh4dXNO?=
 =?iso-2022-jp?B?Vi9rUExHYUx4V0ViYWRGOE56eUhBQkZwTlAzcEJlNTFZLzFYdEdicW92?=
 =?iso-2022-jp?B?cCt4dHM4UVBMejdZZjh6dU51M0FoV1ByeWxENHJ0WkI1N05hN0JHZnFJ?=
 =?iso-2022-jp?B?NjZkSU5JMWdDcjAxamk5T0lBSWVNbWxxS3BPdGpHb25Md2lOSkVYNy95?=
 =?iso-2022-jp?B?UStYZ3VWSUdudnRyd2FkZUdkVFp4WEwvYXhXWUlINjAyTGo0WW93V1p2?=
 =?iso-2022-jp?B?YzF5d3J0T3Z5M1FZN2tvamlFVnYxbnVmemdLbllSVGV0alhqUXRtT20y?=
 =?iso-2022-jp?B?NWxZTnRGd3JiZHZUVm1nN3BiWi9ncWNuSU9CZ0hlLzFySm1IcVRnNS9V?=
 =?iso-2022-jp?B?azJQRytYdWsxVWZvSmtLSkhuampiQnl5cE5GL2dudXl0MGp6VWNUZUdx?=
 =?iso-2022-jp?B?OHdzZXVLOUFhcUNjSmszU1NQNFpOUUhleG1EbG5vTlJEYlNRelI2RFE2?=
 =?iso-2022-jp?B?Zlg5cFgwZFBibk5QdzJFK2VYVFBUTzRsZGFybWJQeGFUaURhZ1JKZ2lE?=
 =?iso-2022-jp?B?Q0s1YnREZVRUVVM5SDJaYmlNR3BMalQvZ21yS1JtN2c5Y3MwMGs2L0Nn?=
 =?iso-2022-jp?B?MUlsdEpHakdsOGV4YURsd2pYZFRzUlo5ejEvK2lHSVlnYlNjUEFZRUNj?=
 =?iso-2022-jp?B?emVsUm83cjV1aDA5dGJwRDNnMnI4SW1PWjhNTkFabTJRQlJrOTNhaElD?=
 =?iso-2022-jp?B?THRaTHZXZDIzajZtWUZIWktNcWljc0tPbVlmNGdIeTYvdVlNbkRWT2dh?=
 =?iso-2022-jp?B?UnU0U25kdWQ0eENqSHE3WU4rU0dKWW1tMlpwSitTdGJPS0QyeWprbFdF?=
 =?iso-2022-jp?B?cUd1VHJOVTcwZVhtbUZSUmtwVWg3Q3YwTzFsUUlxK21kVDZnNm1FQ25i?=
 =?iso-2022-jp?B?ZUUycGxGUmkxNlNnQTlmQysrc3k4bWpYYWNwUjJndTJ3cWlweS9YVXZ6?=
 =?iso-2022-jp?B?alY3R3QvN01NampRbmxMclpNc0M5dlZEeHFpVnhKajRZTEVWK3F6M1hT?=
 =?iso-2022-jp?B?K3FaVm9hcjFDNU4vakI1a2tPZHhhN0RNV0V3WHlJZVFSSTJTQnd4eUxL?=
 =?iso-2022-jp?B?NnhJZnh4bUozZitGaGNqVjVGZzNPdS9Vd0tNOW1vQjF5WU45TkdOZkgz?=
 =?iso-2022-jp?B?eU84cDMwY25aU2RnY2l6czZ1b3gyMkpiS29sRk9HaDVLbGh6YnVXM0o1?=
 =?iso-2022-jp?B?YTIzQUZJakRKNHJ0eEtZcjlsa01tUFF0czZ1MW8yQjdLM3FTQjVqVFZv?=
 =?iso-2022-jp?B?Zk9zM2FkL1c2cDVQTXBiNWFpbjBEWkwyN2RzdUdXSW45SVlQc3JobkZU?=
 =?iso-2022-jp?B?aUU3dlZORHFJR1pYWFNXM3QwdnMyZzRJNkkxc2JtZi9hYVVUQ2o0MEpw?=
 =?iso-2022-jp?B?dGxkN2V0NzhvRFlqbDJHQUJjQXlhRXBsMk9Kb0x2RXFBaDQ3V0dIUHJW?=
 =?iso-2022-jp?B?amJKNUhlV3RYbWhzc28wS0p3aDFnSGF3TllqK0pIbURaV1FvOGc0OEtm?=
 =?iso-2022-jp?B?Z0hRd3JCL0xkTlJDMTJ0d1NUekNwaDYxa2NWTnB5em12ZGowb08zZDVD?=
 =?iso-2022-jp?B?MEdYUThwNEdTMmhaZGY0bGs5VEZRNkdUV0xOY29LdjB2TVFUVjRqbHA4?=
 =?iso-2022-jp?B?dHlwdCs0cy8xdXNpZThoVm5mUXhpRFlSNmZmb1l0MVBNL1paN005TSs4?=
 =?iso-2022-jp?B?MGdHTmNLMlJPb2VsU0ZvOG96c0RtajdlTlQyaEo2WUtJSnhyaVd4Z3lU?=
 =?iso-2022-jp?B?aWJMSVE2MVlJUXRXSXc4RitQODJzekplc29XalNpQXpxaDd6bUYwUGxW?=
 =?iso-2022-jp?B?ak16OEwreXdqZ2N0WjI1bXpadE1KcnAyOWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341f10d5-1825-44a0-28f5-08ddc42d2990
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 05:54:00.6212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5AQIaZJSHYqEKOF3Zpo1CXj27TyDn3kPik6ZJC4Q/OTs/qqqvHrW+37K13QOYE4bJCgzg4oWH8Jfcxcj5IL0oOZQyFLH2LNdcOLCEQ+jIsemzBarzBCZxCzJEfITsydN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10477
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Jul 2025 05:54:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19546

Hi all,

CIP kernel team has released Linux kernel v5.10.239-cip62.
The linux-5.10.y-cip tree has been updated base version from v5.10.238 to v=
5.10.239.
This release also applied DRM updates for the Renesas ARM64 SoCs.

Information about this release is as follows:

  v5.10.239-cip62:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      50e86929b6d357b2419f4c84cc82c4d16e16af72
    fixed CVEs:
      CVE-2025-38332: scsi: lpfc: Use memcpy() for BIOS version
      CVE-2025-37929: arm64: errata: Add missing sentinels to Spectre-BHB M=
IDR arrays
      CVE-2025-38227: media: vidtv: Terminating the subsequent process of i=
nitialization failure
      CVE-2025-38348: wifi: p54: prevent buffer-overflow in p54_rx_eeprom_r=
eadback()
      CVE-2025-38213: vgacon: Add check for vc_origin address range in vgac=
on_scroll()
      CVE-2025-38222: ext4: inline: fix len overflow in ext4_prepare_inline=
_data
      CVE-2025-38298: EDAC/skx_common: Fix general protection fault
      CVE-2025-38153: net: usb: aqc111: fix error handling of usbnet read c=
alls
      CVE-2025-38146: net: openvswitch: Fix the dead loop of MPLS parse
      CVE-2025-38190: atm: Revert atm_account_tx() if copy_from_iter_full()=
 fails.
      CVE-2025-38204: jfs: fix array-index-out-of-bounds read in add_missin=
g_indices
      CVE-2025-38324: mpls: Use rcu_dereference_rtnl() in mpls_route_input_=
rcu().
      CVE-2025-38285: bpf: Fix WARN() in get_bpf_raw_tp_regs
      CVE-2025-38344: ACPICA: fix acpi parse and parseext cache leaks
      CVE-2025-38194: jffs2: check that raw node were preallocated before w=
riting summary
      CVE-2025-38086: net: ch9200: fix uninitialised access during mii_nway=
_restart
      CVE-2025-38115: net_sched: sch_sfq: fix a potential crash on gso_skb =
handling
      CVE-2025-38206: exfat: fix double free in delayed_free
      CVE-2025-38273: net: tipc: fix refcount warning in tipc_aead_encrypt
      CVE-2025-38161: RDMA/mlx5: Fix error flow upon firmware failure for R=
Q destruction
      CVE-2025-38328: jffs2: check jffs2_prealloc_raw_node_refs() result in=
 few other places
      CVE-2025-38147: calipso: Don't call calipso functions for AF_INET sk.
      CVE-2025-38160: clk: bcm: rpi: Add NULL check in raspberrypi_clk_regi=
ster()
      CVE-2025-38218: f2fs: fix to do sanity check on sit_bitmap_size
      CVE-2025-38219: f2fs: prevent kernel warning due to negative i_nlink =
from corrupted image
      CVE-2025-37958: mm/huge_memory: fix dereferencing invalid pmd migrati=
on entry
      CVE-2025-37963: arm64: bpf: Only mitigate cBPF programs loaded by unp=
rivileged users
      CVE-2025-38212: ipc: fix to protect IPCS lookups using RCU
      CVE-2025-38214: fbdev: Fix fb_set_var to prevent null-ptr-deref in fb=
_videomode_to_var
      CVE-2025-38312: fbdev: core: fbcvt: avoid division by 0 in fb_cvt_hpe=
riod()
      CVE-2025-38203: jfs: Fix null-ptr-deref in jfs_ioc_trim
      CVE-2025-38100: x86/iopl: Cure TIF_IO_BITMAP inconsistencies
      CVE-2025-38135: serial: Fix potential null-ptr-deref in mlb_usio_prob=
e()
      CVE-2024-46855: netfilter: nft_socket: fix sk refcount leaks
      CVE-2024-57883: mm: hugetlb: independent PMD page table shared count
      CVE-2025-38185: atm: atmtcp: Free invalid length skb in atmtcp_c_send=
().
      CVE-2025-38226: media: vivid: Change the siize of the composing
      CVE-2025-38138: dmaengine: ti: Add NULL check in udma_probe()
      CVE-2025-38200: i40e: fix MMIO write access to an invalid page in i40=
e_clear_hw
      CVE-2025-38342: software node: Correct a OOB check in software_node_g=
et_reference_args()
      CVE-2025-38083: net_sched: prio: fix a race in prio_tune()
      CVE-2025-37948: arm64: bpf: Add BHB mitigation to the epilogue for cB=
PF programs
      CVE-2025-38107: net_sched: ets: fix a race in ets_qdisc_change()
      CVE-2025-38163: f2fs: fix to do sanity check on sbi->total_valid_bloc=
k_count
      CVE-2025-38173: crypto: marvell/cesa - Handle zero-length skcipher re=
quests
      CVE-2025-38229: media: cxusb: no longer judge rbuf when the write fai=
ls
      CVE-2025-38084: mm/hugetlb: unshare page tables during VMA split, not=
 before
      CVE-2025-38323: net: atm: add lec_mutex
      CVE-2025-38111: net/mdiobus: Fix potential out-of-bounds read/write a=
ccess
      CVE-2025-38286: pinctrl: at91: Fix possible out-of-boundary access
      CVE-2025-38085: mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race
      CVE-2025-38157: wifi: ath9k_htc: Abort software beacon handling if di=
sabled
      CVE-2025-38103: HID: usbhid: Eliminate recurrent out-of-bounds bug in=
 usbhid_parse()
      CVE-2025-38197: platform/x86: dell_rbu: Fix list usage
      CVE-2025-38326: aoe: clean device rq_list in aoedev_downdev()
      CVE-2025-38346: ftrace: Fix UAF when lookup kallsym after ftrace disa=
bled
      CVE-2025-38108: net_sched: red: fix a race in __red_change()
      CVE-2025-38174: thunderbolt: Do not double dequeue a configuration re=
quest
      CVE-2025-38337: jbd2: fix data-race and null-ptr-deref in jbd2_journa=
l_dirty_metadata()
      CVE-2025-38345: ACPICA: fix acpi operand cache leak in dswstate.c
      CVE-2025-38145: soc: aspeed: Add NULL check in aspeed_lpc_enable_snoo=
p()
      CVE-2025-38293: wifi: ath11k: fix node corruption in ar->arvifs list
      CVE-2025-37752: net_sched: sch_sfq: move the limit validation
      CVE-2025-38136: usb: renesas_usbhs: Reorder clock handling and power =
management in probe
      CVE-2025-38180: net: atm: fix /proc/net/atm/lec handling
      CVE-2025-38336: ata: pata_via: Force PIO for ATAPI devices on VT6415/=
VT6330
      CVE-2025-38231: nfsd: Initialize ssc before laundromat_work to preven=
t NULL dereference
      CVE-2025-38143: backlight: pm8941: Add NULL check in wled_configure()
      CVE-2025-38181: calipso: Fix null-ptr-deref in calipso_req_{set,del}a=
ttr().
      CVE-2025-38090: drivers/rapidio/rio_cm.c: prevent possible heap overw=
rite
      CVE-2025-38112: net: Fix TOCTOU issue in sk_is_readable()
      CVE-2025-38237: media: platform: exynos4-is: Add hardware sync wait t=
o fimc_is_hw_change_mode()
      CVE-2025-38184: tipc: fix null-ptr-deref when acquiring remote ip of =
ethernet bearer
      CVE-2025-38320: arm64/ptrace: Fix stack-out-of-bounds read in regs_ge=
t_kernel_stack_nth()
      CVE-2024-57996: net_sched: sch_sfq: don't allow 1 packet limit
      CVE-2025-38313: bus: fsl-mc: fix double-free on mc_dev
    added commits:
      CIP: Bump version suffix to -cip62 after merge from stable
      drm: renesas: rz-du: rzg2l_mipi_dsi: Update the comment in rzg2l_mipi=
_dsi_start_video()
      drm: renesas: Add zpos, alpha and blend properties to RZ/G2L DU
      drm: renesas: Extend RZ/G2L supported KMS formats
      drm: renesas: rz-du: Drop bpp variable from struct rzg2l_du_format_in=
fo
      drm: renesas: rz-du: Add Kconfig dependency between RZG2L_DU and RZG2=
L_MIPI_DSI
      drm: renesas: rz-du: rzg2l_du_encoder: Fix max dot clock for DPI
      drm: renesas: rz-du: Drop DU_MCR0_DPI_OE macro

Best regards,
  Nobuhiro


