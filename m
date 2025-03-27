Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EE1C3600B
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 17:44:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.2663.1743097478295821852
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Mar 2025 10:44:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 52RHiZOW1767199; Fri, 28 Mar 2025 02:44:35 +0900
X-Iguazu-Qid: 2rWhEqwpk340f5AGem
X-Iguazu-QSIG: v=2; s=0; t=1743097474; q=2rWhEqwpk340f5AGem; m=YPFUsYECLAWT+Hnvx8C4GTrPNHoZSYNctl6LwxDZM+s=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 52RHiXP0494205
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 02:44:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUxGi+YkRVGSJOorYbLOhSgygOi/qRcxqSDiyWBYilE1qNsCUwCUMwxhlIQDqgxKOYyr1MfQtpB84VQ5WCG6L3W5YhaxWylPztp0o/TSFHj9AM2JjST4hMBdSVMgM7f5pGDJGgL5sApw3plW0kb1QJr4FVZEiy0h3UKl8Ksd5WaSySy0T19xlGRftRd0k9IqePiR3oonZlHbXJ9la/o1qcGAIGcqLUkDv3mOB5SPidp5+JXW7uaLRSci+40Tu6+F25XheinVmAEbP9UD5gn3M7ailpG+QTELs9L84IfRAqZQmtaQAEfWDXYXxbURsoRZGoNPpGJYKWwjRaxQslT+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuC79lOIyrONAKpyxDQYb08/7VXHhA+XTpwFevIy/TQ=;
 b=ZyQcBaiUNtdCanf60dWBHb3HM/APKsJ3W3TlFsF/gANJ6L1o84fOKghpMt+SpFuFZ/cJhZDhjz92KctGUqWuOv42yfnfGvZibuj/t0xEiSJhy3ISMyby4vszd5qsYZDl4H+XdB1bxyTclFlPl2Drjdpw1bENzm00HkzAMhUhxZR5Wi5QI3NK1MqnG4CSuL548lNVGX/IwPXE9cqyBW0Px4BPxdCL+jKv3ajinlT9gsawtq737wJLGAGbkRlQbCrpMQs5NkT+J03/0o906ckj9AI6jv/E+bGLc0PcF7OZ34z/sJavJsFrjuzdcP0sjiLVQM9KwcqKt1Pwxale526SDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core] IEC_template.yml: Update IEC tests to
 latest revision
Thread-Topic: [cip-dev] [isar-cip-core] IEC_template.yml: Update IEC tests to
 latest revision
Thread-Index: AQHbnvvR641wdLiZTkOct/O1sYjf5rOG2b6AgABSpQCAABRlnQ==
Date: Thu, 27 Mar 2025 17:44:28 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB148384ED75CCF2281745233E5C2A12@OSCPR01MB14838.jpnprd01.prod.outlook.com>
References: <20250327093358.3419546-1-Sai.Sathujoda@toshiba-tsip.com>
 <f04f10cb-7df9-4308-9cd1-b77e6bb6ce7b@siemens.com>
 <c7b75f1c-7ed0-4375-bef7-29347a3613e1@siemens.com>
In-Reply-To: <c7b75f1c-7ed0-4375-bef7-29347a3613e1@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|TYCPR01MB8915:EE_
x-ms-office365-filtering-correlation-id: 78619969-f59f-4f86-6d98-08dd6d570616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|8096899003|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bUFuS2JPTHdyb3VjR0tDN1BOTkUyQVQ1cUhOT1BXWHpBYTRXTkNSQXZL?=
 =?iso-2022-jp?B?Lzc4cWU2VnlkSE9WbmVwcUppcVArTXJIbWtsbTMwSVJ3NzlwRURveVBN?=
 =?iso-2022-jp?B?cmhNL0dQL3RSOEZHZDVXb2dYQnVIZkF5VFBSRW5aQWFIMHdjei9PNElD?=
 =?iso-2022-jp?B?VjRyN28zZEdpanFNMlRTVkQvbXVUQ1ExYU5sejYzSjI3Q1JyaXNFN3FX?=
 =?iso-2022-jp?B?c0N6Y0x6RC9KakRYMG4xUlZmNXF0VDlQZ0tVazZScG51a1d3OG1Fb05Z?=
 =?iso-2022-jp?B?ZFZDOUtiNG9YbkV3bUhZc0I3OGRwczk1UlBHNTY1ZVd6cENrVFE3ZVZX?=
 =?iso-2022-jp?B?TW9OOGE3VFcweForbUlpUnZMOENZVXlWOEdwOTlMakQyYTdNeHVDdU01?=
 =?iso-2022-jp?B?NnkzVFF6V1oxbXJUa2RSNnMrWkhhY3V1KzUzbXorR3dTU1R4SWtBQjYz?=
 =?iso-2022-jp?B?THdiSVFyT21hSjhMaEFHS0xZNVVWcXc2ZU96MVhTWW1HWlNNZCtmTjdV?=
 =?iso-2022-jp?B?UEhOdi9vbEdIRlZmZ3g1VDVVUlkyUlNEZFpteGpLcS9aQzNPVVQ4Ynoy?=
 =?iso-2022-jp?B?bVB2U3ZpNElHdmFOb2IzQWE1MDZOQ1RsUU1ma3NzUVlHd2xrTDVtL0FQ?=
 =?iso-2022-jp?B?alUrOFBJWWlRc1VFb0N2R0R0UW1ra0ZwMitaekxmZldrL2VMQU5tb3BP?=
 =?iso-2022-jp?B?SUVzMlZ2NWNQUlNpTmJ5YWJCUkRNa1JwWkdDbFNWaGJ3Ti9EN2xRemVY?=
 =?iso-2022-jp?B?bERRNCsyaWpnRGRjS2VQUE9yUU0zczV0S1FvZ1hiNGhhOE1tTnBtU2l5?=
 =?iso-2022-jp?B?YzFDM0hJU0pSSWw0ZWxPRzI3TEhmVmlpdUZpU3NaRitjTnA2N2pTTE5R?=
 =?iso-2022-jp?B?dHFlVGh3UUhPK1lRcnFCTkhVM1U3bDVmKzVEbE05eXhkc2hMcGlZRjFU?=
 =?iso-2022-jp?B?MVA2Zk5qSkRmUjVNb1F5TEJsWXUxTlR4QzgxdklDOUJiMExWUXM4S0Fw?=
 =?iso-2022-jp?B?QkxyaHNDTUlHU3l2ZDh0Vy9YZnJnRmhLNkN5RUJPN1VPWGFTQzloWmI0?=
 =?iso-2022-jp?B?dVRTdGEzT1BOVXRLZlFDY1JOU2Q1RDB4OFQ2M3NEc0ltZ3RDUFlTVEth?=
 =?iso-2022-jp?B?bHBHOFVZV1dJRlE1S0ZpVjMxT0taRW12Vm1LRWpwczRveVFpeXVYSEQw?=
 =?iso-2022-jp?B?S3ZEMHN4STYzLythVTZZd3hOSHZPcXFsd2Z2YWtVYXBkbXhPcWR2OVk2?=
 =?iso-2022-jp?B?QkxNQVU0THo3U25iNGhHNURNeEE2Q0UybkYrL3djTkVKK3FKbTh3YmFj?=
 =?iso-2022-jp?B?YzhjMjNzYWI2Q3VYNzV2a0tBeWgzZHNpUWdhRXV4QjJmMTY3TnNTUFln?=
 =?iso-2022-jp?B?SEhkRXptOXRJUUlzYXcrcjIxQ3VHcklhb2d6aWFYOHpHSGtZZUtsTFRk?=
 =?iso-2022-jp?B?aUlha09FR1BRZzhJSzB0RWxFZE53aWppN2xxMjQxRlNSemxibVYwQlRp?=
 =?iso-2022-jp?B?UVFMOERBQTY4Z0dDTVZuUEtTOCt5aGJMdWp5QXdtSzAxeEFZd1R5UENN?=
 =?iso-2022-jp?B?ejFNMHRYLzRLZCs0VG1zQlRZTWhKSHBSdE53Y0VXMkRJN3NPeEZHNExE?=
 =?iso-2022-jp?B?SXIzRWtwN1lndEY4Q25FekNBNHJPT0loN1lxSUxKVW04bVlqTTluSHFv?=
 =?iso-2022-jp?B?TExacERLaTE2RkRGcEZUTEc0alVVa2NyNWNIOEVJeGExYWtVYjlrb2xO?=
 =?iso-2022-jp?B?ZUFtUE1FdUVKVm0yejQ1MFNOeUtjRDRXSlY3MEViSTczUk1sTk1tc0k3?=
 =?iso-2022-jp?B?eURDVWc0UEk0TmwwaGFYeWduUjZSV0dkK2ExMUU2Yk5ZOGRzYVpiS2wz?=
 =?iso-2022-jp?B?U0xYSjFsNHV0WGpVcDUzRncxazh6UDZCZ09udHdPY0xqNWpic01LUlpW?=
 =?iso-2022-jp?B?a2N2cTRlVG56Tnd4SGtaOEZrcG9OSi9IdTlpQUdPM1N1MEIzZklxWUF1?=
 =?iso-2022-jp?B?cVVkQkFGdVB1eHMyZlZ6QWk5TE9lSnV0MyszcGJkT0dBV3FEd2FsbXk1?=
 =?iso-2022-jp?B?Snc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(8096899003)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Ujc4VDhqVFhEb2xyQUtYcGVNeTI0bStwc2syUlkvNnQ3SEV4d3c4WW05?=
 =?iso-2022-jp?B?bVlqdGtpbDdBZFdUSXdUWEpYV1BidTR2TE9jSUxHamNudXRWWFRCc1dY?=
 =?iso-2022-jp?B?aDYrcVM0NDcyd2VpK3BodU5TMnIwVTN3TkVNSGpPSTNZTDkwc0tUNkt1?=
 =?iso-2022-jp?B?WXZDcHdaWXJoRHJxV1lha1Q3MEZFM0ZmWS9aYjhYQ3JUQStVd1R0dk03?=
 =?iso-2022-jp?B?aHVCNUZSaytzTlYzaEF2a0s5blVzenROYk00L3RHd2lzQXQ0ajVHaUtN?=
 =?iso-2022-jp?B?VGhJVk5KMVRMQlcvSmpTeVBpNTJWWHEzYjE4Rjd0eHV3RWR3YUNHNUxO?=
 =?iso-2022-jp?B?TjdueXBMVGJzbUhKTi9YZm0wUWVLQzBIRnVJVkxtY1Z1ZENQZzFBVW1X?=
 =?iso-2022-jp?B?L3pacmQ3Zms5THhFVTlTVUd2VHV0SHBFdnVaNUFacmpNQVdFOEE0N1ZC?=
 =?iso-2022-jp?B?WVJ4djZQbk1qb0l6MW1ldzFhWjJqc0V4anA5WnpCOERxOHNsNnFLQVNQ?=
 =?iso-2022-jp?B?M2NaNmRGTHVSbTMzMTl1eXZtR2x4NEZlRTVOSWtGSEwvQnM1bVdNN2l2?=
 =?iso-2022-jp?B?bnZTa25TUlVKUk80cVF3SS9xL1h5bDZXeVBRZitDeFdKaE9LMDV2aWtO?=
 =?iso-2022-jp?B?TFc3azlXWFAwZFNWZEpFcFhYRHQxc2NXNzBKVjFza1VTTnhncEhTRnJz?=
 =?iso-2022-jp?B?TmFFdkZ6UTg1VkpRMGZyTlZsd0g2cVhQNzE2SkR3OE1kZzBMYlNUVlhU?=
 =?iso-2022-jp?B?ZWtLV0NOUnBGZDduWGtYMk9IWFJLWkR1V294b1V0eFFrcEJkQ3pOZ1dO?=
 =?iso-2022-jp?B?cWtVUkptcllGci8vdVp2QjYzQTNuZEN5enhEWEJkVGE3TitPQWs5eVNK?=
 =?iso-2022-jp?B?WGdYdjFUK3Z1SzQ0Z1BZWE5MRXl6ZStJSnVIajVlT3pVc0xOQy85ZzJS?=
 =?iso-2022-jp?B?amRTR0hlTDVCM0RUYkRCaGt3U0txQ2dxV0t2Smc1N1ZyRTBGODJYaXd6?=
 =?iso-2022-jp?B?UVZDMjV6Y1ltd20xOFkxVUJUK0NTT0xFOWVaNDJOdHpCUHBXeXdBSm9s?=
 =?iso-2022-jp?B?dHRsOWVJd1NyWUN3LzV5UHBGd05DMU1RSC8vQmlvaW16WmpvRjk5NStv?=
 =?iso-2022-jp?B?SC96cGh6VFgvcjllL2VFWG5ZNTFpbUdLT3MzQ3NBd0lXNXVSN3diQUg3?=
 =?iso-2022-jp?B?RXFpNnRSTFQwaEhFM29KMGl2QzRIdm13WFJ4TFRnc1gwcnpTbDhsTW5E?=
 =?iso-2022-jp?B?OElncy84Y0JmdWF2THZURThqdGxteGJScXV3VklJaFA1L1ZtWm5WbE12?=
 =?iso-2022-jp?B?OVN0SnNiMitvcEIxVllOQWY0WGRCYUtoYjdvdXcxN2FzR3Q1ZFIxTEgx?=
 =?iso-2022-jp?B?MGlXVU9QTWxrVHJGUEUzVWl3RENTYTBwcmxxZFZRT3hZZzRKcWNqdTV3?=
 =?iso-2022-jp?B?bGJIdGk1KzUybmFZcXVrdjU4ZExNUnd0SXRoMEdGOWtBRHltN3RrSXZR?=
 =?iso-2022-jp?B?SW02ZkplUDIyU3QvMFhyQWszc3hqUG5XSVgwOHh2elVkaFFuNDZUYWU4?=
 =?iso-2022-jp?B?ZThWL003OS9iU0NDWWE0N3U2RmYxMm5SZTVCY1pjOHVIN2tObG1yMnlX?=
 =?iso-2022-jp?B?c0loN2doeWRTdlFteDJwTUdVc1ZLMXQ0NXZtWGgvb0V4b2VRRUF2VkQ3?=
 =?iso-2022-jp?B?WWlMU1RFdEx5OVBsVm9LVTBFYWhJUFFKTEFGTkYwbnRNbUI5cUFsYXNn?=
 =?iso-2022-jp?B?YVZxc0JLaUJZeUdNWlRxYS9obE9remkrMGVrbUZ1Q2tLNTZ4bURGYjdh?=
 =?iso-2022-jp?B?elBTREdodjErSGp0Skx1YjBjVWVyT0YrUlpnRFRDdHZNZ0lLY0x1R1FR?=
 =?iso-2022-jp?B?TmpvZUVGOG9KWVdaVE5MN0p1cWNiTHNCYndhZGVnNXpIblBkL2IxSmtE?=
 =?iso-2022-jp?B?Q3dwMDdFMXRCVEtZcmk0NmdSTGxSVVU3cmxUMENtVzlySU1Bdkx0dC9x?=
 =?iso-2022-jp?B?ZXk3VXhBaFkxejNwSnBidDVFS3krTDZOeEJ5MnhtWVkzQWdmS2Q0eC9r?=
 =?iso-2022-jp?B?L2tyOUJBcDh4aktxYTJNMmZYdE00T0NFNzg5ZmZBalRDTUpjU3ZrMWxV?=
 =?iso-2022-jp?B?M0U1N0J6UDV4Y283NXdFdXBHSUNwSVd2OFZpdklrNHVucGJWcURFUGE4?=
 =?iso-2022-jp?B?d2hUam1Va2x6OVRVSGY3SzBNY3BmZmpnL1NqN0JQNVExYWpiYmF5Q2tB?=
 =?iso-2022-jp?B?amo1UlAzR2kvRXBTbTR1RUVNRkhhYXVERG1aMldvU0JLcFVvVXBEU1hD?=
 =?iso-2022-jp?B?U3BIckhKMkVOR2lUbmNjRC9ZQlZRcnRWZHc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB148384ED75CCF2281745233E5C2A12OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78619969-f59f-4f86-6d98-08dd6d570616
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 17:44:28.7741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABPMXE2xaLzsSh20pTX+UFSsstIf5gV8AYZpc4/vcyZ21PuPj5Awe3Whq75eT46iqDVAwk2oniSA1YBMAN2Ge1Rms6KapN49Jy9nieaLiYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8915
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Mar 2025 17:44:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18381

--_000_OSCPR01MB148384ED75CCF2281745233E5C2A12OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

This was neither an issue with the tests nor a problem with the image. The =
tests ran very slow that the overall time allotted (40 minutes) to run all =
the tests was crossed while it was still at 1.9_5.

That is the why the error is lave-test-shell timeout after 2400 seconds.

Thanks and regards,
Sai Ashrith


________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Jan Kiszka via lists.cip-project.org <jan.kiszka=3Dsiemens.com@lists.=
cip-project.org>
Sent: Thursday, March 27, 2025 9:57 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@toshiba-tsi=
p.com>; cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B=
!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core] IEC_template.yml: Update IEC tests t=
o latest revision

On 27.03.25 12:32, Jan Kiszka wrote:
> On 27.03.25 10:33, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>
>> Major changes in this revision update:
>>
>> 1. Skip TC_CR2.7_1 until it is redesigned to remove dependencies on stat=
ic time delays.
>> 2. Improve tests to include testing of new IEC-62443-4-2 sub-requirement=
s.
>> 3. Fail the job if any failed test cases are found in final summary.
>>
>> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>> ---
>>  tests/templates/IEC_template.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_temp=
late.yml
>> index 3c33773..92944da 100644
>> --- a/tests/templates/IEC_template.yml
>> +++ b/tests/templates/IEC_template.yml
>> @@ -64,7 +64,7 @@ actions:
>>       definitions:
>>       - repository: https://gitlab.com/cip-project/cip-testing/cip-secur=
ity-tests.git
>>         from: git
>> -       revision: 064a92b98127b0001ca527a83b175521bea4b626
>> +       revision: 5dbc47f55d4a43449dcbde4363e5d23d6e96344f
>>         path: iec-security-tests/Singlenode-TestDefinition.yaml
>>         name: Security-Testcases
>>
>
> Thanks, applied. Let's watch the pipeline:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/1738025=
966
> :)

2025-03-27T15:03:09 INFO: user: 'user3' created successfully
2025-03-27T15:03:09
2025-03-27T15:03:09 runTest: TC_CR1.9_5: Strength of public key-based authe=
ntication - map authenticated identity to a user
2025-03-27T15:04:46 Marking unfinished test run as failed

Please have a look.

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

--_000_OSCPR01MB148384ED75CCF2281745233E5C2A12OSCPR01MB14838jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Jan,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This was neither an issue with the tests nor a problem&nbsp;with the image.=
 The tests ran very slow that the overall time allotted (40 minutes) to run=
 all the tests was crossed while it was still at 1.9_5.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
That is the why the error is lave-test-shell timeout after 2400 seconds.</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Jan Kiszka via =
lists.cip-project.org &lt;jan.kiszka=3Dsiemens.com@lists.cip-project.org&gt=
;<br>
<b>Sent:</b> Thursday, March 27, 2025 9:57 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Sai.Sathujoda@t=
oshiba-tsip.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-pr=
oject.org&gt;<br>
<b>Cc:</b> dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;dinesh.kumar@t=
oshiba-tsip.com&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M=
#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.c=
o.jp&gt;<br>
<b>Subject:</b> Re: [cip-dev] [isar-cip-core] IEC_template.yml: Update IEC =
tests to latest revision</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 27.03.25 12:32, Jan Kiszka wrote:<br>
&gt; On 27.03.25 10:33, Sai.Sathujoda@toshiba-tsip.com wrote:<br>
&gt;&gt; From: sai ashrith sathujoda &lt;sai.sathujoda@toshiba-tsip.com&gt;=
<br>
&gt;&gt;<br>
&gt;&gt; Major changes in this revision update:<br>
&gt;&gt;<br>
&gt;&gt; 1. Skip TC_CR2.7_1 until it is redesigned to remove dependencies o=
n static time delays.<br>
&gt;&gt; 2. Improve tests to include testing of new IEC-62443-4-2 sub-requi=
rements.<br>
&gt;&gt; 3. Fail the job if any failed test cases are found in final summar=
y.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: sai ashrith sathujoda &lt;sai.sathujoda@toshiba-tsi=
p.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; tests/templates/IEC_template.yml | 2 +-<br>
&gt;&gt;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/tests/templates/IEC_template.yml b/tests/templates/IE=
C_template.yml<br>
&gt;&gt; index 3c33773..92944da 100644<br>
&gt;&gt; --- a/tests/templates/IEC_template.yml<br>
&gt;&gt; +++ b/tests/templates/IEC_template.yml<br>
&gt;&gt; @@ -64,7 +64,7 @@ actions:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; definitions:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - repository: <a href=3D"https=
://gitlab.com/cip-project/cip-testing/cip-security-tests.git">
https://gitlab.com/cip-project/cip-testing/cip-security-tests.git</a><br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from: git<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; revision: 064a92b98127b0001c=
a527a83b175521bea4b626<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; revision: 5dbc47f55d4a43449d=
cbde4363e5d23d6e96344f<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path: iec-security=
-tests/Singlenode-TestDefinition.yaml<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name: Security-Tes=
tcases<br>
&gt;&gt;&nbsp; <br>
&gt; <br>
&gt; Thanks, applied. Let's watch the pipeline:<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pip=
elines/1738025966">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/173802596=
6</a><br>
&gt; :)<br>
<br>
2025-03-27T15:03:09 INFO: user: 'user3' created successfully<br>
2025-03-27T15:03:09 <br>
2025-03-27T15:03:09 runTest: TC_CR1.9_5: Strength of public key-based authe=
ntication - map authenticated identity to a user<br>
2025-03-27T15:04:46 Marking unfinished test run as failed<br>
<br>
Please have a look.<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</div>
</span></font></div>
</body>
</html>

--_000_OSCPR01MB148384ED75CCF2281745233E5C2A12OSCPR01MB14838jp_--


