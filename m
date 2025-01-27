Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AADC0218C
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 04:38:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.44951.1737952704132875692
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Jan 2025 20:38:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=Ex5aQvmP;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1737952691;x=1739162291;bh=K1HN93JujC5StuglPO8wUfca4ZYi9lZbRYBRhH1
	TqOs=;b=Ex5aQvmP2sdk0uQ0epNBcSBRotsPgXLmng8CbkBnOKAaI8fXBYgKKjzZegGxoFMuPCyEw
	A/2Ox1uHyRAqpJPAzaoQ+ZyTH969BQVN9b+veAdwaIAakG1+qW69Rk7iWLYZy/HGM5hUVQ0fl2p+a
	IDzte/NkeJZ1CxGhYtAhm+nY8jBmLd6xviwk8ArdJ4YfsJvP5rXB/FyUI/I/mbJcYAGAaVdiXYlld
	x1XiXdYoJzrbB+QMTGjIdHEnR6yUHV9kRj2G5WRSMda4FxXeuks/8gSqV5cTvDYbflIbluHFSl5Qz
	DXsYtHJKlAsNHHjVNbXvwHWIy9MVA5exnuqkK0lT3Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 50R4cArS2218549; Mon, 27 Jan 2025 13:38:11 +0900
X-Iguazu-Qid: 2rWhiV7hQKezEeB1YT
X-Iguazu-QSIG: v=2; s=0; t=1737952690; q=2rWhiV7hQKezEeB1YT; m=vtbOvxCAwdwh2sOe5f+RMm41rHpBQSp7QcPKWJE99Lw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 50R4c90D2555060
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 13:38:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekl4h8t9s9pn6E2Qd3KO507r320pJKTIZL1ztClOs1RviGHhEFQYJkPRL3Se332BTceVN7G+bgTZY12RJcIEYtGPKB6N71b2HZlFLEUSebMgazeWOuBmA724jAMfaDXz8ldcnvAT6zEHUOloCl0xoNE95t/9U2Vuid0AxPZslo8lIDbwY/EvYdm83DWoG37ukjCgAv8/+yxoXhx/LXwGz97BWmVQpcmstd537/fwd9KC+/SkFc5m8Z+q2F+4WdBx5/oLi9hKT7FA9sR0mbFdU6b1varqym/3NCy/6m0fxSZlOW+k1oa3m/XDCbDS5q5uAfPbFh28zlcXkLNeM93GGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1HN93JujC5StuglPO8wUfca4ZYi9lZbRYBRhH1TqOs=;
 b=HYwpluGoml7VpNqB4agQ+zaS0k/m2RtpFrFQb9OQukKFvDde9CHsXkOhd+9E8uuabmIxiAT2kok+zDt14JOWxLrWnl+T4J3wB2+w0eXt6rxYb3GsRxk8CDm+4Ym8jZLmTm/Y6DJVZjwhUJITm4xNHZUYGIusCC9i12VjG2kvT0j2gJvt+ZQ1tKxeJabsNBWY08letFjoNzeMz3+mvA3UOcxFVHvY5z6Fyxgu13vsGznKQIGW+ReJ0B7Cp6Szmdp0sl9GmGwS6Uiq5pOevjlVHNCiLJgjKCdBaMUo9zPLrZYi+Q0MTWWhcBkasjj8lMM3uWF9PUw84YFpGHpiA9276A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH v5.10.y-cip v2 00/16] renesas: rzg3s: backport the RTC
 support
Thread-Topic: [PATCH v5.10.y-cip v2 00/16] renesas: rzg3s: backport the RTC
 support
Thread-Index: AQHbbj59ZcE9+RLJJ0WRuYImRIYKnLMqDblQ
Date: Mon, 27 Jan 2025 04:38:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63889338043BE4C1609EBEB492EC2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYYPR01MB12507:EE_
x-ms-office365-filtering-correlation-id: ba9a8470-9063-49d9-a8db-08dd3e8c6568
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cGxoNkpOYkRpSlo5OFg4c3JpTHNlNkNXdllLaks1cXY4cnUzSTJ4ZExVazZi?=
 =?utf-8?B?UTlwcjcwelRKQndVc0lRUW9wTEJPVkZuZzNRRTZXQmdDbEVjbjNYeUhKcVZh?=
 =?utf-8?B?bUtqWXo0VDV4aGF1S3hMVmxlVTBNMDM3aVJlamNSdy9KUEZiQkxFcVRDZWRx?=
 =?utf-8?B?NmZtQ2RhL3FvTVk3M2xOb3BJZ3VGbzRDbW9SYUY5RFUyQkViRU0zVURKNTRW?=
 =?utf-8?B?ckZJa2wyZzBPQUVYY1ZSMDJiVHZNVm5BdkFxRHV3SzFqSGhIL3RZQXAwS0Rz?=
 =?utf-8?B?WlhnZUloK29GSkpYa09GWk1MOWpqWFRhc0kwVUZIQllxaW5YS3c2NmxwZWFr?=
 =?utf-8?B?SnE3TElnTnlCcWdveDBNM2pCMHQzUXByNGduckNDVE0zNTZ5dnZJNE41V1pM?=
 =?utf-8?B?cHY1bDJ3Nng3Y3kvT0dETFRkR2VNR1I3N0FMcXI0TE5YRk44QzVEUEN4MEpI?=
 =?utf-8?B?d2NGK3VRSDFLb2RQdUxNSmJpTy9qZmN5bnNFOWJDdnQ1d2dmNXNZWkRlb3ZE?=
 =?utf-8?B?OWJ6YUk4YVBCbXZWRW40RjFBalBiemJCSU9pbWlXSk14UGZlcXNQaFB3L0RM?=
 =?utf-8?B?L3NwWllEZzZXdVpOc2h5QmovaFZlUTdPVnJHTjRSdVFPTmhnMjE5R0JaSVhu?=
 =?utf-8?B?Uk1VY3VGNVlBZkx0NUE3TnRpcnFBT2kxY3RWVGd1R1dQYXFnMlY0U1dCeEly?=
 =?utf-8?B?Y2EzVGhFRUIzeTBSc29FdHlTb24rRmNFNnFuVzFoS0srVFZ1Z1ZFbXNrQ1Ux?=
 =?utf-8?B?ZXZSM0RZWXdid1RkMjUvQlFhY3p1dHJEK1dSbmRDTDNLNjZaaGxYckp5VE4v?=
 =?utf-8?B?cEJQOVNXQk5pMFZEUnRYTjhpMHgvNHE2TWhCZXRqTmFpQzI3akl5NTZyV2Mx?=
 =?utf-8?B?ZkZpR0JUV2M0c01SbkV1MlVPYkpINlBhNGh6YWVhTU9LMUJPSDY4WFRtbXNw?=
 =?utf-8?B?MWN2ZDBBUGZiaFBGbHhoQ0ZLS0JuSndUWTNCZDJQYmlSbHZVWjFaNW5rT3ps?=
 =?utf-8?B?bFdveTR6QTdBbW1veXZna1o3VWRUK3p0K1dlTzJPeHNTTU9mQnBGMHZ2aWs1?=
 =?utf-8?B?M0E4Y1dyblhjencyUUJsSHlRRHFiMzdIZXo5N2F1Z0lwQ0xJV1dLVys1Q3Y1?=
 =?utf-8?B?UkpEWjY2OEd5V3IrZTl1a2tNQ2ROS053MzhONGNMUWlabFhXSDVGT2pTWVY4?=
 =?utf-8?B?aVJhbEMxeTd3cmxtb3NnU0dkMERLL1BQaXhpMEF1ckEwQTFjMC8wTkl2UUhh?=
 =?utf-8?B?VUh2MHdNQU5KZ2U0YWtoMTgvOEMyRWt4cEs2TWV1ZXNmbW9yeE9CeG10dDY1?=
 =?utf-8?B?b3haWSt4OGlFeWw1SlRMVGYxc21IWlVhUE96WHJQQ2poeHR4UjJJSURlbUlw?=
 =?utf-8?B?V0hDaHdvNFRaKzFmNnZtYXlMZDJKYzZmRGFpaXYxOFpRZGZvaGdZbTdVZmFG?=
 =?utf-8?B?LzBFSVJmVlRsekZCdUVpckZYbDRpYVVDWGdOckl5K1hyb3VXNHVmTkpnQ29h?=
 =?utf-8?B?RCs3MDVqWjFGMzNCTXQ1UFJHckJJREwyNUJzNnBzc0ZneUdhRmlSSTJKN3Az?=
 =?utf-8?B?RDh3K3hiYWg2MkVwdGVMMU5udkhCdWlOeC95b20zWXdCdXJlVElkTit1Q29Z?=
 =?utf-8?B?dXprOUdJbVRURHRXdEIrWWNmcEVEUGFmaWszNVFXaklQd0wxcHJmRkdJZFg4?=
 =?utf-8?B?eG9jcWkzY0lROFhPcUZFMG5udFdVWFV1eTVFOXFMWnJib3NibTQ0bkM2K2ox?=
 =?utf-8?B?YVhzNGd0bHlIeW53czR1Q0dJUTNqVTdTUXZHRllSMXBxYjBLZklKUGg3UU5J?=
 =?utf-8?B?VitQbTd4TTlFd0dqZFBJVklTaDBzblBYV0dLZUlLVjVUamlPSWhrN0FnUUdQ?=
 =?utf-8?B?aUtOd0doUDM0RUhkT0JoZnRWejZGT3BxYlFpTVMzZ0tWQWlBVnZ3RXI5NUIw?=
 =?utf-8?Q?7M4gFr21VSakk3eWUZ98LhbhPL94rUfL?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NFRhMEVYWmJGcXhSaXNndGpHU3VOeUV5UW9XVURsWkNhSUl3L3g3ZkdSa1BC?=
 =?utf-8?B?N1dwclVsVXd1c3l2a3BpY2o2d3Y1dlgzWnFKZWdoRlJIRXoxTkYxV3J6bW1Y?=
 =?utf-8?B?Rm16bmZVZUY4QnNuRkNWMHpuWnN6WHEreEZxVVVjLy92Tit5bzlTa3VOUDVi?=
 =?utf-8?B?UE04YlZ4TUo1ODd3SzJkY3lqc2JBSDFLTlh0dWc0ZHFrempqMTBWZVlvNGph?=
 =?utf-8?B?SzcwbEhMbHQ2U2hqVCtIclFtWXhxeWljcTJFSjJwWHFpNC9xcXlOZkFMbkxo?=
 =?utf-8?B?dyszbUlNeVhCNFMzWUZtenE5RTRGeURRVmprNi9wTEFnUm4ydFgvTnFFd3RF?=
 =?utf-8?B?N21HSSt2dVZLeFZhYXZ4QzY0VnJ1QTh5THRSdzdmWmJRU0VrdlRFUm1OejFR?=
 =?utf-8?B?aXpvbkJBUlpwaTJ0ZG03WlJsK1NTY3dXVlljTUpDbnB3cjhlYU9WVlpZVmZT?=
 =?utf-8?B?Nm1LM0NOcmxYVjh4RjF1U0treDB5b2poWEdJTEVvMWZBWVhTeTlkdk5PY2Nv?=
 =?utf-8?B?OXFmYWw4WTdMT2FBbjY3NXV4NklsUjV2VjV1MW1tUkFFQTR6RVJ4WnlTVm40?=
 =?utf-8?B?a2IvRG52Mnl1VDhEQnd5RGxpdlhKKzNSSzBjQnlLNVU4THZpRUVCMmJhNnRT?=
 =?utf-8?B?WTc0S3lTSkZydHVjbThLR0lVWDNYNW9OU2s2alZqaWpYNnF2ckFGbGwwYmdM?=
 =?utf-8?B?UU1JN3REOHNTcHdzUGpWM1pyL2FRSmxxSjRNVlptbUVZSWFwbXlqTURMQWV2?=
 =?utf-8?B?TnZ0Ynp1UWZ5T1JNSjBoMjlUeU9IcU1hMG5SMjdQVExEV2NZbzNURW52dTRI?=
 =?utf-8?B?eEswMy9GbFEyRTRhRnFRK3A1dDZGSU1KM3ZmdEhwT25zbjBMcEN1Z21jODJk?=
 =?utf-8?B?OFBrZHFIVk1CY0RPS1RkL3A3MnJvckFNQmI3TWlFR0RQRU5haklyUXRCSTVS?=
 =?utf-8?B?Yyt0OVg5MmwvZ3grVUN2dDRZS255ZzFxNTVvdUswL1p0VE0yQXIyVjNoRHA2?=
 =?utf-8?B?TVNQQzRJK055dkQ0UUt2ZGFkT053TStoYW9hK2JDcHlXR3BjajZBYk5Ud0tG?=
 =?utf-8?B?QXFkZU5FVGZFYjNEM3I0cTFWTWtZUDlXWXVNcUc0a09reUJPR2pHekNlQVRx?=
 =?utf-8?B?b0xIQlppZjBFZGdMVnlVdStmUGNCVk5qSVV4T2JnUEZZNC9WSzBGODhsNXFl?=
 =?utf-8?B?bnE1SmloUEhaTEQ1RUh3YlBpdW13eVpnbFJ4bWZ6eUNrSGRPRU1Wa3Blb2tH?=
 =?utf-8?B?ZThHR3M5N29PNEliZE1zL2pXSXNoQ0R0RWMvYkZlVjZDcjdSenVEVkY3elpn?=
 =?utf-8?B?K1N6ODErTU0wTVo3L2pxWkQ4d1JiUnJTYmp0WG83UlZoZklYYjJBSDVJNmRu?=
 =?utf-8?B?ZDA3M05WTURDZlljTzNCRy9XdzhKT2FZVzdYY3piUVVmQWRZRGlzR3NocGVw?=
 =?utf-8?B?ZlNCNG83SE1XazRiNHFRM1NpSmNmQWJLdmhDSDVveGNJNUk4ZEpJN2FkMWht?=
 =?utf-8?B?djJqdkVuLzJBdlI4Q0gwQUM5bFdPWGZSdCtId2UwS0pQZ2JBZW1MdWhEUjlE?=
 =?utf-8?B?eXJxSmdPaUxlclJxR1g4ckczUkVaZEFEWUIvT0Q1ZTZxTEttOHVKQ0xaR0o5?=
 =?utf-8?B?ZzB3WldYb2w0bC9uWDBsVTVHUVJOTVpEL0ducHNUZTFFSkRSeGFDMnBVS1Zm?=
 =?utf-8?B?aE8rSlRwS1hiMU5DYTZNQzZ2VXNQUWxUUmlST2dOaGhsVW00ZFBNSnpSQ3Va?=
 =?utf-8?B?anE3VGRiemtCL215ZUYyMXFmVVo3cW9HWFFEOUl1SGFYOU4wdUY2eHQrMHV4?=
 =?utf-8?B?L3ltU0UxMm1CMVFUeXVMVDJwSFgvVnVBR2NUdHhrazhvd3JNT3daZ1c1UUZh?=
 =?utf-8?B?YVpKMFplbGtXQ1ErOWhua0pZampLRFhGeVEvVjJBN2xFZEZwb3JOOW5nR2RJ?=
 =?utf-8?B?TWR3eDBkVUZ1bDZpOHBLNlprK25QeVJIWHNULzRRWmsrSlh2eTB3TzFRK2JV?=
 =?utf-8?B?ZDZvWFk1V3ljdlhncjI0aEJ3ZU9hckZGNlNUNnRUWFZSejhRNmx0YnV0QTZ5?=
 =?utf-8?B?b3EzU0wxVWxVWStrbVdvUzJOUzQraW81R21YUXgxUVU4NGptMW5uSnlxWDJT?=
 =?utf-8?B?SnpwaXJyYlBobXNndlkzbS9WWXp3L1dqSURBZHlhbWlMWkFFTHlvV3A0WHV1?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9a8470-9063-49d9-a8db-08dd3e8c6568
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 04:38:07.3559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4bauuOnqHhOCVE4K78U8uTlzom5fHSWefKzYhZkLB9SVYFY7JTs2HbKhR3+cthDE8n1cL39vYyPOKT0LWpC/8wDkWHDgjG6aBYAkzRj2rErn0MAcnZHClrAEhLzd04w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12507
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jan 2025 04:38:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17666

SGkgQ2xhdWRpdSwNCg0KVGhhbmtzIGZvciB1cGRhdGUgdGhpcyBzZXJpZXMuDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2xhdWRpdSA8Y2xhdWRpdS5iZXpuZWFAdHV4
b24uZGV2Pg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMjQsIDIwMjUgNjowMCBQTQ0KPiBUbzog
aXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnv
vLTil4vvvK/vvLPvvLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IHBh
dmVsQGRlbnguZGUNCj4gQ2M6IGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldjsgY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHY1LjEwLnktY2lwIHYyIDAwLzE2
XSByZW5lc2FzOiByemczczogYmFja3BvcnQgdGhlIFJUQw0KPiBzdXBwb3J0DQo+IA0KPiBGcm9t
OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+IA0K
PiBIaSwNCj4gDQo+IFNlcmllcyBiYWNrcG9ydHMgdGhlIFJUQyBzdXBwb3J0IGZvciB0aGUgUmVu
ZXNhcyBSWi9HM1MgU29DLg0KPiBBbG9uZyB3aXRoIGEgY2xvY2sgZHJpdmVyIGZvciB0aGUgY2xv
Y2sgcHJvdmlkZWQgdGhlIFZCQVRUQiBpcyBpbmNsdWRlZCBhcyB0aGlzDQo+IGlzIGNyaXRpY2Fs
IGZvciB0aGUgUlRDIHRvIHdvcmssIGFzIGl0IGZlZWRzIHRoZSBSVEMgY291bnRlci4NCj4gDQo+
IEZvciB0aGUgVkJBVFRCIGNsb2NrIGRyaXZlciB0aGUgZm9sbG93aW5nIHBhdGNoZXMgd2VyZSBh
bHNvDQo+IGJhY2twb3J0ZWQ6DQo+IC0gY2xrOiBnYXRlOiBBZGQgZGV2bV9jbGtfaHdfcmVnaXN0
ZXJfZ2F0ZSgpDQo+IC0gY2xrOiBtdXg6IEludHJvZHVjZSBkZXZtX2Nsa19od19yZWdpc3Rlcl9t
dXhfcGFyZW50X2h3cygpDQo+IC0gY2xrOiBmaXhlZC1mYWN0b3I6IGFkZCBmd25hbWUtYmFzZWQg
Y29uc3RydWN0b3IgZnVuY3Rpb25zDQo+IA0KPiBhbmQgYWRqdXN0ZWQgYWNjb3JkaW5nbHksIGlm
IG5lZWRlZC4NCj4gDQo+IEZvciB0aGUgc2FtZSBWQkFUVEIgY2xvY2sgZHJpdmVyIHRoZQ0KPiBk
ZXZtX2Nsa19od19yZWdpc3Rlcl9nYXRlX3BhcmVudF9kYXRhKCkgd2FzIGJhY2twb3J0ZWQgZnJv
bSB0aGUgdXBzdHJlYW0NCj4gY29tbWl0IGQ1NGMxZmQ0YTUxZSAoIkFkZCBjbG9jayBkcml2ZXIg
Zm9yIFN1bnBsdXMgU1A3MDIxIFNvQyIpIGluIHRoZQ0KPiBwYXRjaCAiY2xrOiBBZGQgZGV2bV9j
bGtfaHdfcmVnaXN0ZXJfZ2F0ZV9wYXJlbnRfZGF0YSgpIi4NCj4gDQo+IFRoYW5rIHlvdSwNCj4g
Q2xhdWRpdSBCZXpuZWENCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gYWRqdXN0ZWQgdGhlIHBh
dGNoIHRpdGxlIGFuZCBkZXNjcmlwdGlvbiBmb3IgcGF0Y2ggMS8xDQo+IC0gY29sbGVjdGVkIHRh
Z3MNCj4gDQo+IENsYXVkaXUgQmV6bmVhICgxMyk6DQo+ICAgY2xrOiBBZGQgZGV2bV9jbGtfaHdf
cmVnaXN0ZXJfZ2F0ZV9wYXJlbnRfZGF0YSgpDQo+ICAgY2xrOiBBZGQgZGV2bV9jbGtfaHdfcmVn
aXN0ZXJfZ2F0ZV9wYXJlbnRfaHcoKQ0KPiAgIGR0LWJpbmRpbmdzOiBjbG9jazogcmVuZXNhcyxy
OWEwOGcwNDUtdmJhdHRiOiBEb2N1bWVudCBWQkFUVEINCj4gICBjbGs6IHJlbmVzYXM6IHZiYXR0
YjogQWRkIFZCQVRUQiBjbG9jayBkcml2ZXINCj4gICBjbGs6IHJlbmVzYXM6IHI5YTA4ZzA0NTog
QWRkIGNsb2NrLCByZXNldCBhbmQgcG93ZXIgZG9tYWluIHN1cHBvcnQgZm9yDQo+ICAgICB0aGUg
VkJBVFRCIElQDQo+ICAgZHQtYmluZGluZ3M6IHJ0YzogcmVuZXNhcyxyemczcy1ydGM6IERvY3Vt
ZW50IHRoZSBSZW5lc2FzIFJUQ0EtMyBJUA0KPiAgIHJ0YzogcmVuZXNhcy1ydGNhMzogQWRkIGRy
aXZlciBmb3IgUlRDQS0zIGF2YWlsYWJsZSBvbiBSZW5lc2FzIFJaL0czUw0KPiAgICAgU29DDQo+
ICAgcnRjOiByZW5lc2FzLXJ0Y2EzOiBGaXggY29tcGlsYXRpb24gZXJyb3Igb24gUklTQy1WDQo+
ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjlhMDhnMDQ1OiBBZGQgVkJBVFRCIG5vZGUNCj4gICBh
cm02NDogZHRzOiByZW5lc2FzOiByemczcy1zbWFyYy1zb206IEVuYWJsZSBWQkFUVEINCj4gICBh
cm02NDogZHRzOiByZW5lc2FzOiByOWEwOGcwNDU6IEFkZCBSVEMgbm9kZQ0KPiAgIGFybTY0OiBk
dHM6IHJlbmVzYXM6IHJ6ZzNzLXNtYXJjLXNvbTogRW5hYmxlIFJUQw0KPiAgIGFybTY0OiBkZWZj
b25maWc6IEVuYWJsZSBWQkFUVEIgY2xvY2sgYW5kIFJlbmVzYXMgUlRDQS0zDQoNCkFwcGxpZWQs
IHRoYW5rcy4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K


