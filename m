Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528C1E77188
	for <webhook@archiver.kernel.org>; Thu, 26 Dec 2024 04:10:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.17190.1735186243443440676
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Dec 2024 20:10:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=LnkgbOBn;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1735186240;x=1736395840;bh=H8
	BV8DaMks5/OsFUPY+TrTZ7JehVP8LnPXBbONIwh9E=;b=LnkgbOBnA+PAVrvmzP7aG3R1/Ol6xTrz
	htwo70S7hwBdXK/ZnF03g870kgU1VrXJwKQNRFTIvnt8u9TLXn5ecklmNP6i8rzxLF8uo6cESicCj
	6P2yOVKO9ai1B5eyUDNJoIUTwjDbsGr7ILm7juTI15s+hFwEC7ukqEsUedvtSgXTAXVD/q/08/vxw
	vyvhZyeKtcW1hyajs36OxeLK2gYglYRhKIJ4XXWp2No/IWkckJFKGYSMgAotR7PiPkD21yQ8+Z7o4
	WHYlQoXz+g1dCKxjfuiLZ6zAa3MvqzERa6dMpJdhvLZv/Kw7Ls0e+rA4IsrqUCxb3Sfa4aLO3JtPk
	Rg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4BQ4Aea73118966; Thu, 26 Dec 2024 13:10:40 +0900
X-Iguazu-Qid: 2rWhiV7hPSF1Bvelhk
X-Iguazu-QSIG: v=2; s=0; t=1735186239; q=2rWhiV7hPSF1Bvelhk; m=7Ix4gIKd45x6MOejK99UvfVlNLSWm3kmmj77i875Z14=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 4BQ4Ac2t2434301
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 13:10:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDLWkd1T93vL/HrXQth3Zc5wD/XrLU4E/YgErPE3RY+D/cd4wpq7kcrHup5pbfyfUAw+MTBmm2VbbMDkR65mFPiBhCZaFDWjJ+YL83U3Re0zY7bAqSGjubRPZGzmp3nG9rZakFM4hzmPuPde7j/LbbYk/K8bhH5pamiGcOmvKgIrQE22jlTlY8ZOnlLS63GqrczSliuD4r4QxvGD9J4g+2Zn6wPiv1jk9OH3BDZSuySHGUDmY37TcCz3Xo0HJXTbVbto1H3MqfU8pZEnHzuZYdUfprrEulwKMfpvb/7XbhcCFcGxBYLlOSFpe2osg42SKN5g0tK1Vsqa+TRnYb0n/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPOvmMSSjwcM/DYRZUJKXzYzZNi62t7WCHdzif/cc7s=;
 b=bY3Ety0elIltPWjRXce4Hz9gJom2lgHvMGdJao82h+0Y/jkPNVxRzrandM6VbvUJO+6FHnMh/tccPNB6YxcpWIayps4hR0sMqM/0H/0xEe3BdGvyPibCONS+1R+zUe9TChFxXPDsTjq0x/MCmiVQBpA4qB++HDyihOeDV4zigj/8KPPSkBU3Sr7d+ZdsiRgFdeIhfek7kexUZwyzdn4xTQJZY6HVQUTACrus7sy49U4vvYrFuw3q3U7Aj/n9xq3wCJDhpNGBfEWaEnUpNezgMymCKQ7y3W3XY1JX2+ioZgHW58GSWDVf8wHmwop2vKdO+PBrkdiInIuVDDYNWH8Iqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today on libera.chat / 20241226
Thread-Topic: CIP IRC weekly meeting today on libera.chat / 20241226
Thread-Index: AdtXS6+xHCZBpQSSS7e2FxHW+FggJw==
Date: Thu, 26 Dec 2024 04:10:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6391A227C0BC50B50099F83E920D2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|TYCPR01MB9750:EE_
x-ms-office365-filtering-correlation-id: a8e3f82a-abc6-478d-5286-08dd25634034
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ckU5Z1hyaXFoazBXT2FVUFNuZkNMbzBsczI2NHBLZDIycEwxSXJqaUFs?=
 =?iso-2022-jp?B?aVVlckJSK05qSEJDRVdRcGJ0U2JBaDNIK0ZScTBuZ1lHRG5HREM3dmM0?=
 =?iso-2022-jp?B?NmZEL1N4MjNXRkdVWlR6MlZzamxJemUwUmVuUlROWEFOVW45Y1Btditz?=
 =?iso-2022-jp?B?UXdXak11cnIyT0Vjd1FCQS9PL3pHR3VjOXgwR3R0b09GZVVyL05pdnZV?=
 =?iso-2022-jp?B?SzlkVkt4MTg5ZzZLUlUrNy9ZdzdpT3gvbTExMDF0eXcwZnZxZm0wc2tV?=
 =?iso-2022-jp?B?UTNaSmRkenpNYkRVKzIydTd5M2g0Z2MrTi9KTEFnSUdib25DMGZTOXB3?=
 =?iso-2022-jp?B?anpSZXFwTmsvaDQwUW5NcHY5MEJQWlNRdCtVRUV1NW9INjY2TW43QXN2?=
 =?iso-2022-jp?B?dUhxVFRKRzVYUTRWVmNjK0hCekxsWFp5cE1sc2FGang1c3R2RkMzT0hD?=
 =?iso-2022-jp?B?WkRwdXNRNmx5ZVJMbDRaMTdUZUUvOUluelJadXpZRXN1YmlobXlReFlN?=
 =?iso-2022-jp?B?RUFzKzBMdkZWMzgrTjZFdFAwM1NiNVY0UHZXODhsMUk5aWducjRvVWJi?=
 =?iso-2022-jp?B?emt1T2xYckh3dzE3SXNuVmZZMDIzNDVuSU84VWE4aGRnQXBEZ3ROWXo4?=
 =?iso-2022-jp?B?TGVTemdHeGR0STRSL1IwVitjNGZuWUJpdUtxOEpSdzV5SVNVU3NvOFBi?=
 =?iso-2022-jp?B?U3VvMlJsd05FVG05c0F3MlFPUCtHZmFENy9VOUdDRlpFSmxmdXhDNXRp?=
 =?iso-2022-jp?B?SFJZWTJIaGRTNEpQNVcxWDAxL1NDRVIwaFF5MklWekQ4NkdtUEJoQ0FB?=
 =?iso-2022-jp?B?TlBOOWMrYVFSUzBBZ1QzNzlMWHBWdlBCK0NJK3pVb21oZXhXN0hhMXBo?=
 =?iso-2022-jp?B?UFc2T0p3NkU5UWpkUFpVTzZybnZ3UEM0RmkxaXJWdFczdGc0MXovQ2hH?=
 =?iso-2022-jp?B?WUxLQVJMZ0U2WTlGbTZ5d2gyTUM4bGZISVR4cUJkb1NBSmE3Q2NvWWR4?=
 =?iso-2022-jp?B?SmZXT1FsZVpXczFTdEtXT3ZBTDN1dTUvR2FwcUdnMFhieDlVL0ZQQWtr?=
 =?iso-2022-jp?B?Q1E4SkdZSUhjV1JidHhUd0tlRXA0c29sL01QVEdhWEI1dGFycFpGTEJZ?=
 =?iso-2022-jp?B?TEhpS3lyMnJHcEdQZVJuWFdMcmo4NEhWWm5zMTJoTjlrZGRudWhSdlhl?=
 =?iso-2022-jp?B?b3YxV215L1Y1bXJBcjVva3BnbW9MVlFIZzVoSmxVeEpjNkFTazRtc2NK?=
 =?iso-2022-jp?B?emNHdm5kenRqendmYmcwZFBDN0FWV0FJZnoxSlNHU2djbFRla05YdXp6?=
 =?iso-2022-jp?B?SnlaeGlKeDJnL0UvbFp5MDJOVDVZZ1AxQVF6dWVkb25wbHJEYjVoMll0?=
 =?iso-2022-jp?B?WGlOOTFVNzJoa09ub1JnQ3pRR3lkTVFjK0U2V1ZSZ3BUaXFKNE1yNUpm?=
 =?iso-2022-jp?B?Z3BOYzluSTg3TzZhd1Q3bEFnRjc5QjJjTnVha1RackhkeURydHlLc0hH?=
 =?iso-2022-jp?B?QU8wWWZIUFVNWGRleW5LSFpHNDZmTCtITUJtUlhYVitjT2o4cFk0WnE1?=
 =?iso-2022-jp?B?ZXlVdGY4K2FUa2Q3N1FVbTA1QnYyR1lNdExJeVlwUXg4aWpDeUR4ckFj?=
 =?iso-2022-jp?B?RTNGbEFZaWcvZVkzZjJoOWRHUzhjd085WTVZOHdqVVFJSGtXeHhXT1ph?=
 =?iso-2022-jp?B?SllkZloxZmNmYlp0MzZacEV5VUhnbXJCVldZS2hmRmVycFpEZmxaS1I1?=
 =?iso-2022-jp?B?WEsreVZmZG1EQWtNKzJtck1YdEZ4czlycko2R3RPemN6SGRVM1E5K1BD?=
 =?iso-2022-jp?B?bW13aUw2eTlpN3BjWEI1bkNhQnFaSU5McGQvclFJekJpNDVScmtKdWpC?=
 =?iso-2022-jp?B?c0tMTGJJOTkvWitsMW1FYktvYUY3citZN3VsN0h6ZWxENThoVllhc24z?=
 =?iso-2022-jp?B?bXROcm5yNVNhdFV5MHVqK2xxNVEvR0Zpc3lYKytETWlYb3JLNlR5cFlM?=
 =?iso-2022-jp?B?RWVpREZjMGtrbjlvZC9iSkxOb0xpL0Q0RzBTT1o1RU82WmFRVjh6WEh3?=
 =?iso-2022-jp?B?Z2RGRGNjcUdRSHBqcmREcU1qYnRsd2s9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RUVZZmM5REp3aURlMTMzaTdzQjBtSThRZjRqTGRDNkxxNmZmM1VoZGM2?=
 =?iso-2022-jp?B?dnRzN3pHRnNrUmdtUDZMZldKLzVyMWtvOFoyVStTd1FwL09sMnN2Nm1v?=
 =?iso-2022-jp?B?bGYzakRubTA2bldJMzR0UHE0YTdiNUpwMnZSN0pvelA1Q2M1WEpWQXhp?=
 =?iso-2022-jp?B?Mkl2QS9lVWpxaVpiQXlmYmIxS0tkdjZ1T0ZKTldmYkxPTnpvWW1Pakh2?=
 =?iso-2022-jp?B?UWxITDM2amp2WXlQRk8yRnhnWXlQQXdFR1NjaDVqZmZoL05KZjdLTHRr?=
 =?iso-2022-jp?B?SlVaTE1rcmpvNGZPUEZDQ0wyNzBKUC9oblozVHcvaE5CclAxMTBZdUFK?=
 =?iso-2022-jp?B?eTMwNEgwS0ZDQlVDWjg5eW9EQldhdTFuMXRnMituT3lmemZrc3UxYzUw?=
 =?iso-2022-jp?B?cUdXSWNvVnV1WVMwVzlJT2hSakNtOFhDZDlYdElua1M1SUxaNm9iY3dy?=
 =?iso-2022-jp?B?T2FuSFNCU29pR0hIL1dydXFvUmxJc0dORUhkOEZDMFhjQzZHWGVmdmRU?=
 =?iso-2022-jp?B?U3hpT1pzcUxSeGJRbHFvdWRxZnlqRmtHQmZpNStTMDRnQTlWYmpkU0xS?=
 =?iso-2022-jp?B?bkhnMGNDZGtVbGV1RlFobjhGOFZkVFFreFQ5MEducUFMYlFsVWtsMFE3?=
 =?iso-2022-jp?B?TVRScTlPWTQ5Z2hjTXE5dHVqL1pxM2RzcVBSV2ZMMXNpd1hyRUpacFRv?=
 =?iso-2022-jp?B?RFdhMEh2Y0ExdEgrY01nb2hOUno5V2V0T3AyanJheHdPNjZhTmZFVVZR?=
 =?iso-2022-jp?B?SHdITXczTVQyVHRMWVF1Z0JPZ0N6ZjlJWnBPVHpSZEFpQUtGbkNvVG91?=
 =?iso-2022-jp?B?VnM1eTR5dlZrWmxGZ2xrUmxoZGtSaGtnUnUzK3hJS2wwM0VlNWoybEJ3?=
 =?iso-2022-jp?B?Nmk3cE1Da2JGNy9UZlcyTEpZaFJZeEd4WHhDRE95Y2taQmpyaGtZbVho?=
 =?iso-2022-jp?B?OVlnUkdvRnR3VStWZXM1QUNySkJqMGhRZHlELzVSWlpiaDZlc0tOMWlw?=
 =?iso-2022-jp?B?QUNhYktBK0FMdFRyT2srRkpRdjNkUHhXamNRWjM4aTQyR21aTVNORGE1?=
 =?iso-2022-jp?B?VWxsbGZUY1ZCUHFLam1nSC9aY3d5aENxUlpHOHZ3OEh2S0FMem14YUFo?=
 =?iso-2022-jp?B?SU5kZm5oR2pHa2NNVGEwcVdreWR1aTBSbUNNTkFBckc2Q0EyVEdKanRS?=
 =?iso-2022-jp?B?dGZrdlJvOE52dGJTTHB5bGVrcEJhRllpVmhwSGRsL0U4UEFkbGI1RzdP?=
 =?iso-2022-jp?B?NFB5VUNRUTJVV1hqNVVJZG5JTjBpNHhhdFhFUEQwcldCb2Q0QzBoYUFB?=
 =?iso-2022-jp?B?ZTFoRU9oTmVBczdpVXhybzZ4REJIVG9abE9zcDZ0Q1M3TGFoeWtkV2xp?=
 =?iso-2022-jp?B?bFFHa29DVVdZVmpTSUdSMVJBRTkzNVhBT25VZDFmWEtIeVdjWVQySm5X?=
 =?iso-2022-jp?B?L09QanVEV0llVTBSY1F6VE5xQ2lwTlVPM3d6bkN4bFN5c1RjRkVaS0Qr?=
 =?iso-2022-jp?B?WER6cEY4RFdzenp2cTlobk5qS0dFZXA2aXRUR3JMNHJXSmlGN1FxQjV4?=
 =?iso-2022-jp?B?dS82a0J5T3R4SnB2aFkzVCt4Q010TWJBNk04TDVlSDk2MlRMbkpQdUhx?=
 =?iso-2022-jp?B?TGJQZUVmcnhkRVpRZldFY2xWWloyYWxkSStWWWlvdjFKZ0ZrZnpOU1NR?=
 =?iso-2022-jp?B?TEVjM3lDcnptTTErWUJpUGQwbEpVN3c1WWJtVjVJcHgxNkJ4ZnF1VWtR?=
 =?iso-2022-jp?B?MFJQQWt5bEpxRGZkQ3ZPZkFQMXRVOXhIbk5CSHFMTlIyc3FPWEVvTTRQ?=
 =?iso-2022-jp?B?azYxYi9obnRMbm1NcDJYeDJzeklBanVtQTYrUkJrS0xmSjVZbllHMkYv?=
 =?iso-2022-jp?B?cmdhVi9iTjNmNGZVY0dJRGtUUUwyL3lBRmxmNnBRREdMSGIxb0hlb0Za?=
 =?iso-2022-jp?B?YmhCTkxTYTgwSkdKbVZRQkNwQWoxb1hoNUVtWHBGMVNIOVUwNWxQSDVP?=
 =?iso-2022-jp?B?eVJJcWIxKzEzN1FnVjdkZUhoZ0NUWHd2Y0VzOWJDVXJ2cmFjeVZNWHhu?=
 =?iso-2022-jp?B?elprTXROOXAxS2pWNzRnT2FBeGl2TnJZQ1pWLzQ4VUk0cDlnQkk4dGNS?=
 =?iso-2022-jp?B?MWhOU0FJdnU2bXFqcWRpL2ZFc1hWWVpwUThFZWhZK0ptWHRZbWhmZzIv?=
 =?iso-2022-jp?B?VkxrbWE3eis4d3VXNnZBTC9JdXZHd0w5UVFGVEl6N1dBV2dzaVVlSW5o?=
 =?iso-2022-jp?B?SWU0TUs4UG8rclJDeHlKempYMDA5YzNlYk4vemNRMGhGZ2F5QkpveVRr?=
 =?iso-2022-jp?B?aUFMeUZodVBralErWDFNd1lISHZKWTdFMmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e3f82a-abc6-478d-5286-08dd25634034
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2024 04:10:36.5546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdhdnuUEyXFJoUbYifJsHUcwJprMCdWCN5b8d2mXVNvqdIBMF/tfGroR7zt5FY8ZQ5uurc5OrHY8RqNoS6a7HnnCaTrAEKrmrJ0gwdLKB9oKdAlgPt8sUL5ZdtUAV547
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Dec 2024 04:10:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17495

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2024&mont=
h=3D12&day=3D12&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/12/cip.2024-12-19-1=
3.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Best regards,
  Nobuhiro

[*]
Date the data is created: Thu Dec 26 04:07:11 AM UTC 2024
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip94
  latest version release date: Thu Dec  5 05:21:08 AM UTC 2024
  limit date: Sat Jan  4 05:21:08 AM UTC 2025
  Status: =1B[32mOn track=1B[m
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip94-rt52
  latest version release date: Thu Dec 12 10:45:41 AM UTC 2024
  limit date: Mon Feb 10 10:45:41 AM UTC 2025
  Status: =1B[32mOn track=1B[m
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.324-cip115
  latest version release date: Sat Dec  7 07:05:01 PM UTC 2024
  limit date: Mon Jan  6 07:05:01 PM UTC 2025
  Status: =1B[32mOn track=1B[m
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.324-cip115-rt39
  latest version release date: Mon Dec  9 12:30:02 PM UTC 2024
  limit date: Fri Feb  7 12:30:02 PM UTC 2025
  Status: =1B[32mOn track=1B[m
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.230-cip55
  latest version release date: Wed Dec 11 05:28:57 AM UTC 2024
  limit date: Fri Jan 10 05:28:57 AM UTC 2025
  Status: =1B[32mOn track=1B[m
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.229-cip54-rt23
  latest version release date: Tue Nov 26 03:12:05 PM UTC 2024
  limit date: Sat Jan 25 03:12:05 PM UTC 2025
  Status: =1B[32mOn track=1B[m
linux-6.1.y-cip: interval 15 day
  latest version: v6.1.119-cip33
  latest version release date: Wed Dec 11 01:47:08 AM UTC 2024
  limit date: Thu Dec 26 01:47:08 AM UTC 2024
  Status: =1B[31mlate=1B[m
linux-6.1.y-cip-rt: interval 30 day
  latest version: v6.1.119-cip33-rt18
  latest version release date: Thu Dec 12 10:20:12 AM UTC 2024
  limit date: Sat Jan 11 10:20:12 AM UTC 2025
  Status: =1B[32mOn track=1B[m


