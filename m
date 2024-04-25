Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEA7C4345F
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 12:21:10 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.73])
 by mx.groups.io with SMTP id smtpd.web10.15401.1714047404593840242
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 05:16:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ocl47x+P;
 spf=pass (domain: siemens.com, ip: 40.107.8.73, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0Fbn2kY46QeXEC8sdwRYZAqGcn+fOV9+j1qs3TRqaebWwuFEBnao6501DztSAodXNcLMHAyxdy76uYMjgb5oJIDtECyNhVv1+/Z4u7LSIStOczxRIPzFp5w3mMr2DjmjLGDvu9fKIazuiRLoQvv/4bVdByCkgs/dnp12IG+S0RcPZsq2ZPoc1Scyy7zBD2eDSIeNti3L+cZkbMW3UivjWtSsq6xHZzbs8ZoiOc9gJ1EvvIMXJlBnn/b2W0yPNkSGNmoD7oaKs4zn6lUA/uylI2APScCAIYDNqr9aEnF/IHVvUnlckfKbEccAoKLEXtxQv63fCVlG2+VK11Z2xYl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSbVg/qVLQ4SlTn6usFpRRUchgYPV0ITfxfnHE7YJ74=;
 b=A+ouuZL9ZSX2ETTNrnkbdspJgCavhB0/+HxdujsqpCV7AMNiLn46wtVNoc4w64EY/7wTxGCfHxFrQ05XDSktjF6fwgKZrhbvSTARrhHmeLlWtOBM0wjEENJa5OzoOU4lSP09PR/TEnLQ8GxsstgnsiQEXoSML75kAnGXfVnziXEiysPaKNfhucGbdWhcKnOZr6H9xFPlcJ4F7SjUTDGPYbAcEsevCR2l+Z7magq+jZO4cu1C6M2HS8GWhb7PHHCNSnWZT2o+MyP3B2rRWGlwONCZommR7qmxuCLLMLnStodRq9GxjjsUBzg87Gw+VbqBlogST02kqKTUTSCU2gZENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSbVg/qVLQ4SlTn6usFpRRUchgYPV0ITfxfnHE7YJ74=;
 b=Ocl47x+PnZ8A0YC+yyFKG+JfDK/eN1WVwkJIy1T7A1TC+3PoksM0AtOepZ0mAVx/qBtAtwYnzliULEg0S2kpAe4SJ0A9D9dn6aaMg0gj88QWBUjqMABBMcHnRl1V6q2Whlg/JqhBPXBX9f/CzePltiqMQ2seaCyn2FMPVXdN3r+lJIxlcbIAH65lS+X4WwEP17pl4SWTSGdaXh9RKqohfVEi7Q+NHQvlrAcsVNZDquCHSVj/kZLizOvunmLkl0d2Vlj/p+O9Fi8QPPQx5lMINIcMJh3T7dhXPviUcmHpzX8yFbxhZuvLIghx7uRwU23VeQoh8/XU/mNeHiR5G721WQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by PA2PR10MB8943.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 12:16:39 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 12:16:39 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 6/9] Kconfig: Add option to encrypt the rootfs
Thread-Topic: [cip-dev][isar-cip-core][PATCH v3 6/9] Kconfig: Add option to
 encrypt the rootfs
Thread-Index: AQHalwbl8C6ez1sanEKNWEEqRJWNIrF45soA
Date: Thu, 25 Apr 2024 12:16:39 +0000
Message-ID: <f6f0d888d300d17ec35ca7040b687d67e6d45aa8.camel@siemens.com>
References: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
	 <20240425115119.813384-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240425115119.813384-7-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|PA2PR10MB8943:EE_
x-ms-office365-filtering-correlation-id: 637a1c1f-427e-475c-81c6-08dc65218f8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cEg1UnRBZEdwQno3RjM3ZU9veDlLTURrMkJWTkxRdnFMRndycHdJb0R5Z3dP?=
 =?utf-8?B?ZncxVW96bWFBMTNyV04weUZMQllRQjlLeWRXZ0dVWHY5WmdpenhDMWdWODhx?=
 =?utf-8?B?WmRjcGxHQ2tNYW5FUkZJUm5XT1VaU1UwUFgyZzVqWXdLOVk4ZXpnNkp2TnMy?=
 =?utf-8?B?cWVrNjA0VFd0RlU3Y2Zvc1Bwbm1pY3cvYVBDM1liQjNiK0kwa3d4UzAvQzJo?=
 =?utf-8?B?Sm5qU3JFUStmbHZydXpIckdzYmJkVGplZWxTT0wyUTM2U2drb2J5TkV2VVRE?=
 =?utf-8?B?M2NRTVRRc1RNdW44OTcrS3FRK0VBcXZUWm1Ha0h4ZjZrU1BncXV5eHdrRzhJ?=
 =?utf-8?B?bHQ4aEVMTXc3cjc1NjcwbzNsd0RuK0N6bzNaMmNJd3ZGMU8ybnBkeDl1NVow?=
 =?utf-8?B?R1B2dTZha1c0UlNwejFBOTdjNEI4bUw2ZnV3ZDR0R3RQNlBsUU16YXdGdEtp?=
 =?utf-8?B?SnhqUDllaXAramxQbnlHV3lYMmxiTXhmQzUyM1p0MWwxeWM1aG05WkRTQjcx?=
 =?utf-8?B?eWozaU5Gd1Z1cDN4WVliMGl3TFhmMVMwTUIvckFHb1Y4eVlzOFMwYlF5dXFh?=
 =?utf-8?B?aS9iWGMvQWxJUFNlVjRLL09vS1pTQVJTYjRzS1F4ZDBSbHJFdG1DY0I5WmRo?=
 =?utf-8?B?bm5sY1lWWU5GVm04a2g0ZkJSRjlIZ09Ec2wzeVVNeVdXdGxtOW9icTBIRTVq?=
 =?utf-8?B?SC9XTDdtMEExSmNoUEh1VUt1akMzd3hIWXpmQytXU2JDbWpFU3A3NjFrU2xj?=
 =?utf-8?B?a0VvRlEvVUp4R3E1K1FON0cxd2NEc1FtUTNvME96RGF4a1QxbWFOUkwrSk1F?=
 =?utf-8?B?SW0vU3ZOdFZmVTYvNk1PbW5xQzhRa2x1RkdYbUxTSzFNbE9lcDc5a3IzRVRJ?=
 =?utf-8?B?bGt6NlJ6c3hBTlNHUnplZHRyODJBNDhvakVadGxJWVA3V0Zlc1EyK3RaNUxS?=
 =?utf-8?B?QTErUEwySmkrTmhuVStrYlRtR0RkV1BnR3ZidXh2TDRiblhtZlVSK0gvL2d1?=
 =?utf-8?B?bVR6MHNtWEQwcDcvL1VxVHdHMEpOSFErTk1OaUsyb3MrckllN21VY3h1QkFM?=
 =?utf-8?B?cHJYUVVhaGxBeVRPTHY1eXJWTVV1clZzbzVIY3g5ZFhtVDlhdTFXVCt4SlNU?=
 =?utf-8?B?TzZ1aU41UkZaTWo2SWZvbzZ6MmNab0IzcjhHWWNLSnVQNmJnenlzRUZQM252?=
 =?utf-8?B?alRxVVdxKzYyRXU1R3pyZWY0dXd6R3ZINEpkRG9CeWsyb28rbGpsQXZHVHAw?=
 =?utf-8?B?a1NUaFltVkNhVUIrZEtIK2lCcWZBNEJ0MTI5TGxIYkZEWk02aFM4OUJmcDB1?=
 =?utf-8?B?WXpzU21HcVlnQkJXVGxDZURIdG1WTjNyTnpoRU81ajFRbXQ4MllXS1lOY1E2?=
 =?utf-8?B?Rm9pbVhoaFBhcjJlWGhuMjlzUVNSYzBkM3U5SzBEcUFMSFlXZkxjNGxQSzgy?=
 =?utf-8?B?Sy9MQURsVVN6MlN2QlZ4Yy9oR2lJL3FyV1BZZkRiV3Joek9EeFpzNk45Rnlw?=
 =?utf-8?B?Z0FmTjZTenpGUTMza05ZMmVLeXRadVJBQWsxTGFkTkYwK05RVnBYVDhSQlFO?=
 =?utf-8?B?NTlxNEc1c2NmVFY2ZWZ5ZXdURWl3c2hOY2liNU1sRENodHBxaWRtcEc0UjVD?=
 =?utf-8?B?UXhjYVpxQTU0c25odnJuNVRzTjVaTVY0NTBHRVVCZ1gzZHRzaHZNSi9jaUUv?=
 =?utf-8?B?S3grZ3ZacUhhZ0ZOZHVjbE5YNTZIaDhKbDBiQjYxSGUzVXFjNVk2TWg1bjc4?=
 =?utf-8?B?RGNBMXZJSnZ1VmlMZGdDV0t6aXo2MnZ1dXd6VXVwRnZ5Rjc1bVZpTko4eWJp?=
 =?utf-8?B?WFFyN2l3MmpvM0ZLVUt0UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?amErS1Z0ZWZFWW44NlBNVElRZEpFcDVLOFNnU0RZWHN5YVNha2V1bXRWUnJ2?=
 =?utf-8?B?MlZ6SUI1YWNZSjEvaUV5Y3FIbDc5SXRNUzU3RlZaZnoxeS9JSW5od0tIQVNt?=
 =?utf-8?B?QTY3S2RZWUQrdlhsYWJhd3JWQVo5VVB2ZzBQVmtVUi96RmNBMCtQanVYblg1?=
 =?utf-8?B?TmVSclFLbkJQV1piM3ZDR0FGRytzdlVLZnMzREFjM055OVFUcUN1dllRNFpu?=
 =?utf-8?B?bDB0OHhNa1VvUkJncUs4Rm4xN2g1YVZ5ZUw4OGd5WVhmeGFxcmhQeXBvdVBl?=
 =?utf-8?B?VnpTaC9sVFRCTzdUSDNWRm1vMmNFbnREYXVtbUJsajU5cXd3MTBoelpsOGd2?=
 =?utf-8?B?OXMxYlM5dFJUcXB1WCtvd3IvTDY4djFQUDBsait1V0NkTHhJcWk1c1BYU2tt?=
 =?utf-8?B?OW5VclhXOTQ5TEhYMDdBVHhCTy9hazQ3eVczZzNveDVaOEhtL2VNRURMdWFx?=
 =?utf-8?B?aW9PQ1pxazRac29FRDFST2YwMDBuRkhhQmU3WVB5cnZpQVhDbGFmam5oSkRD?=
 =?utf-8?B?UHdVUDRXVTREc3hDRThmVElBU3NQcVd4RmRoUnQ3Yit0ZWZ5TmdiRXpXVGR4?=
 =?utf-8?B?WHpXVVVSSmpLZmJXL28xWVhkYlRWQ3YwTHRYb1VnL1FkVXYyYmNOcUFWd3l5?=
 =?utf-8?B?ak40dmk3YXFTRFBBY1RHNWJLVitNR0JPdXRNcXRhOGViVUZ3eUVwb1BUZ1k1?=
 =?utf-8?B?eG5NOUZuU2poTzZVRWFQSTdNZjdNeDRrVFRPRTAzSkh6N0V6aUQwUVFaS2t1?=
 =?utf-8?B?YXdNMjZXZTV3VGxzRUZxcTY4TXYxR3VNaUtTbm9jeEVLWGFKZkRpS0s2ZmtZ?=
 =?utf-8?B?Z0xkZExISWdKa2I1U1RDa2FLc24zdTZ2OUdUR0x5Z1dTTm5lZUtaQUEzL0dV?=
 =?utf-8?B?cWJCUG5hNmN5MkJsUFg2M2VTbktRTkdqbE85NitpVXJmUmhLL3BuOFhZSHBW?=
 =?utf-8?B?VjVVUmRsdzFmN3ozU3owSlhva0RRTG5SWlpOTWUvTzI5MU1ZKyt3VmpNNHNz?=
 =?utf-8?B?ZDBOdWcyNE04N1Nhb3lzenVtdkJTWFB0SGRrWHdsUUp0eTg5S1dyM3lVclB4?=
 =?utf-8?B?eVIwMkV3VEVOZDVxR3EyYi93cFZUcWg2NzhFdnpVaFlIUlV2bDh4djNtRnox?=
 =?utf-8?B?UDNlVStMejF1Z3JOU0dpM0RvdUFCUGY4MlRyQmVOUHJySkdGRHMwdWVUcjlF?=
 =?utf-8?B?WXFJZTQ4VlNrenovMzhVLzg4ZFdaMjB3NDFpTFd5ZVpQVmQ2MjBTM09BM3gy?=
 =?utf-8?B?MFlYQ3FBSXFLeEl2YXU1VG5uSncyczE3V09QLzhXUHNpbHNkMVhXSDFiemNl?=
 =?utf-8?B?ZlFIay84RXQyWUI1c3BWWi9jdHVXazBDdDhBMUhQWlN0dWpBT3JiSGd2dlFq?=
 =?utf-8?B?Q2xGVFlqTkRwaDg1Qjk5QjMwTVNGMy84SVhNbERZRVF3V0paRUY4TDFPSEc4?=
 =?utf-8?B?SFljR1FYamNqK2c4WUE5d01ZdlhhNEhidGtId2FobUE2aXFTNno1VkJNWTZv?=
 =?utf-8?B?QWR2eTlGSjVxSllZWk53M3NLbVcwVUVVeVNCQnJQQ1F2U0NKalBpM3p2ejZh?=
 =?utf-8?B?TmlwaUFuRml5MGxUTEhGZE1icXJnWUY1RXVWUXc0bzlIbENyUDYxdUpYV0d6?=
 =?utf-8?B?VVNYcnlWNExhNGR2SEp0cUgydUIrVHRGL2ZLa2ZwRng5Vk5IS3M0U080Z3BB?=
 =?utf-8?B?RlFoQkV1NjlFMDJ6a3RYNUtXdWJMczFTbWpHZlBza2h0SXFlaHlEZFJoR3ZE?=
 =?utf-8?B?NmxUTDNEamI5ZWJ4U3IrY3VUMW8zcUxhNi9ReEtUWEJRWjBlSEpobDRmaitV?=
 =?utf-8?B?bk56c25nVGpZM3lCQ1p1WFBFaU1uM09QdmFudUFQc3hRT2FVdW80MzhZK2g0?=
 =?utf-8?B?K01McU5MZFZIRFdKRnFRclFZSDZ3RCtZSGNZcysyMldoMSs2Q1FIMmk0WFNk?=
 =?utf-8?B?RmhXdmxsZXVYUEwwSG55UVB4UWlDYTc5OFBKejVRSmkrQitzWE9Nc0pRaFRL?=
 =?utf-8?B?Z3lJMUtDdmtPR1orV1lpOUE2S3FIRTV5dVAxTytxbkhDbVpveDdlRDVKUE4w?=
 =?utf-8?B?cFJVQnZwaG1xM0Z2Nm1CbjZGZDVveXN5bFFLNldiUWNZcVk2RWFVY0JrcTJ2?=
 =?utf-8?B?QXA1UDczUTk0RkxEaEp0Um9oZG9aZFl2cUFmZmwvaGx1aC9FVlpTcWUrWHZM?=
 =?utf-8?B?TFcyQzJ3RE95MzFQc1dwSjdnd3FWeXYvRzNWbUY1Mnh2Mm9xc1NaVXVXQmdp?=
 =?utf-8?Q?NbtJV4uJYZdc2B52YYRMH/ww2otPdudVeqB8AisEso=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 637a1c1f-427e-475c-81c6-08dc65218f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 12:16:39.6131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drz2i6Ui+NaqpKc+fBNxErnQ6F3ePlMc5+n20EHqNb0sokLVcsCg/vrlRRUQJaMHN26+RZqQoKbfypSNYRtxUiQoKh0qhTk6uK18d7QgoZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8943
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A04A305A6A0E7940A91DAC9CE6ED1BE1@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 12:21:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15767

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDEzOjUwICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBhbGxvd3MgdG8gc2V0dXAgYSBmdWxsIGVuY3J5cHRlZCBzeXN0ZW0uDQoN
Ck5pdCBwaWNrOiBUaGVyZSBpcyBubyAiZnVsbCBkaXNrIGVuY3J5cHRpb24iIGZvciBFRkkuIEF0
IGxlYXN0IHRoZSBFU1ANCnBhcnRpdGlvbiAoYW5kIHRoZSBFQkcgcGFydHMgaW4gb3VyIGNhc2Up
IGNhbm5vdCBiZSBlbmNyeXB0ZWQgLSBieQ0KZGVzaWduLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiAtLS0N
Cj4gwqBLY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyMCArKysrKysr
KysrKysrKysrKystLQ0KPiDCoGthcy9vcHQvZW5jcnlwdC1hbGwueW1sIHwgMjMgKysrKysrKysr
KysrKysrKysrKysrKysNCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGthcy9vcHQvZW5jcnlwdC1hbGwu
eW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvS2NvbmZpZyBiL0tjb25maWcNCj4gaW5kZXggOTQ3OGEw
Ni4uNDJlNmI2NyAxMDA2NDQNCj4gLS0tIGEvS2NvbmZpZw0KPiArKysgYi9LY29uZmlnDQo+IEBA
IC0yMDIsMTUgKzIwMiwzMSBAQCBjb25maWcgS0FTX0lOQ0xVREVfU1dVUERBVEVfU0VDQk9PVA0K
PiDCoMKgwqDCoMKgwqDCoMKgZGVmYXVsdCAia2FzL29wdC9lYmctc3d1LnltbCIgaWYgSU1BR0Vf
U1dVUERBVEUgJiYNCj4gIUlNQUdFX1NFQ1VSRV9CT09UDQo+IMKgwqDCoMKgwqDCoMKgwqBkZWZh
dWx0ICJrYXMvb3B0L2ViZy1zZWN1cmUtYm9vdC1zbmFrZW9pbC55bWwiIGlmDQo+IElNQUdFX1NF
Q1VSRV9CT09UDQo+IMKgDQo+ICsNCj4gK21lbnVjb25maWcgRElTS19FTkNSWVBUSU9ODQo+ICvC
oMKgwqDCoMKgwqDCoGJvb2wNCj4gK8KgwqDCoMKgwqDCoMKgcHJvbXB0ICJkaXNrIGVuY3J5cHRp
b24iDQo+ICvCoMKgwqDCoMKgwqDCoHNlbGVjdCBJTUFHRV9TRUNVUkVfQk9PVA0KPiArDQo+IMKg
Y29uZmlnIElNQUdFX0RBVEFfRU5DUllQVElPTg0KPiDCoMKgwqDCoMKgwqDCoMKgYm9vbCAiRW5j
cnlwdCBkYXRhIHBhcnRpdGlvbnMgb24gZmlyc3QgYm9vdCINCj4gLcKgwqDCoMKgwqDCoMKgZGVw
ZW5kcyBvbiBUQVJHRVRfUUVNVV9BTUQ2NCB8fCBUQVJHRVRfUUVNVV9BUk02NCB8fA0KPiBUQVJH
RVRfUUVNVV9BUk0NCj4gLcKgwqDCoMKgwqDCoMKgc2VsZWN0IElNQUdFX1NFQ1VSRV9CT09UDQo+
ICvCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gRElTS19FTkNSWVBUSU9OICYmIChUQVJHRVRfUUVN
VV9BTUQ2NCB8fA0KPiBUQVJHRVRfUUVNVV9BUk02NCB8fCBUQVJHRVRfUUVNVV9BUk0pDQo+IMKg
wqDCoMKgwqDCoMKgwqBoZWxwDQo+IMKgwqDCoMKgwqDCoMKgwqDCoCBUaGlzIGVuYWJsZXMgTFVL
UyBlbmNyeXB0aW9uIGZvciB0aGUgcGFydGl0aW9ucyAvdmFyIGFuZA0KPiAvaG9tZS4NCj4gwqAN
Cj4gK2NvbmZpZyBJTUFHRV9GVUxMX0VOQ1JZUFRJT04NCj4gK8KgwqDCoMKgwqDCoMKgYm9vbCAi
RW5jcnlwdCByb290ZnMgYW5kIGRhdGEgcGFydGl0aW9ucyINCj4gK8KgwqDCoMKgwqDCoMKgZGVw
ZW5kcyBvbiBESVNLX0VOQ1JZUFRJT04gJiYgKFRBUkdFVF9RRU1VX0FNRDY0IHx8DQo+IFRBUkdF
VF9RRU1VX0FSTTY0IHx8IFRBUkdFVF9RRU1VX0FSTSkNCj4gK8KgwqDCoMKgwqDCoMKgc2VsZWN0
IElNQUdFX0RBVEFfRU5DUllQVElPTg0KPiArwqDCoMKgwqDCoMKgwqBoZWxwDQo+ICvCoMKgwqDC
oMKgwqDCoMKgIFRoaXMgZW5hYmxlcyBMVUtTIGVuY3J5cHRpb24gZm9yIGFsbCBwYXJ0aXRpb25z
Lg0KPiArDQo+IMKgY29uZmlnIEtBU19JTkNMVURFX0RBVEFfRU5DUllQVElPTg0KPiDCoMKgwqDC
oMKgwqDCoMKgc3RyaW5nDQo+IMKgwqDCoMKgwqDCoMKgwqBkZWZhdWx0ICJrYXMvb3B0L2VuY3J5
cHQtZGF0YS55bWwiIGlmIElNQUdFX0RBVEFfRU5DUllQVElPTg0KPiDCoA0KPiArY29uZmlnIEtB
U19JTkNMVURFX0ZVTExfRU5DUllQVElPTg0KDQpXaHkgbm90IEtBU19JTkNMVURFX1JPT1RGU19F
TkNSWVBUSU9OID8NCg0KQW55d2F5cywgaXQncyBqdXN0IGEgbml0IHBpY2suIENhbiBiZSBpZ25v
cmVkLg0KDQpGZWxpeA0KDQo+ICvCoMKgwqDCoMKgwqDCoHN0cmluZw0KPiArwqDCoMKgwqDCoMKg
wqBkZWZhdWx0ICJrYXMvb3B0L2VuY3J5cHQtYWxsLnltbCIgaWYgSU1BR0VfRlVMTF9FTkNSWVBU
SU9ODQo+ICsNCj4gwqBlbmRpZg0KPiBkaWZmIC0tZ2l0IGEva2FzL29wdC9lbmNyeXB0LWFsbC55
bWwgYi9rYXMvb3B0L2VuY3J5cHQtYWxsLnltbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBp
bmRleCAwMDAwMDAwLi5iNmQ0MDQxDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIva2FzL29wdC9l
bmNyeXB0LWFsbC55bWwNCj4gQEAgLTAsMCArMSwyMyBAQA0KPiArIw0KPiArIyBDSVAgQ29yZSwg
Z2VuZXJpYyBwcm9maWxlDQo+ICsjDQo+ICsjIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAy
NA0KPiArIw0KPiArIyBBdXRob3JzOg0KPiArI8KgIFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5n
eWxzdG9yZmZAc2llbWVucy5jb20+DQo+ICsjDQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBNSVQNCj4gKyMNCj4gKw0KPiAraGVhZGVyOg0KPiArwqAgdmVyc2lvbjogMTQNCj4gK8KgIGlu
Y2x1ZGVzOg0KPiArwqDCoMKgIC0ga2FzL29wdC9lbmNyeXB0LWRhdGEueW1sDQo+ICtsb2NhbF9j
b25mX2hlYWRlcjoNCj4gK8KgIGVuY3J5cHRlZF9yb290OiB8DQo+ICvCoMKgwqAgIyBEbyBub3Qg
c2V0IG1vdW50IHBvaW50cyBmb3Igc3lzdGVtYSBhbmQgc3lzdGVtYiBhcyB0aGV5IGFyZQ0KPiBt
b3VudGVkIGJ5IHRoZQ0KPiArwqDCoMKgICMgYWJyb290ZnMvdmVyaXR5IGluaXRyYW1mcw0KPiAr
wqDCoMKgICMgQXMgd2UgdXNlIGEgd2VhayBkZWZhdWx0IGFzc2lnbm1lbnQgaW4gdGhlIGludHJh
bWZzLWNyeXB0LWhvb2sNCj4gcmVjaXBlIHdlIG5lZWQNCj4gK8KgwqDCoCAjIHRvIHNldCBhbGwg
cGFydGl0aW9ucw0KPiArwqDCoMKgIENSWVBUX1BBUlRJVElPTlMgPSAiJHtBQlJPT1RGU19QQVJU
X1VVSURfQX06OnJlZW5jcnlwdA0KPiAke0FCUk9PVEZTX1BBUlRfVVVJRF9CfTo6cmVlbmNyeXB0
IFwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBo
b21lOi9ob21lOnJlZW5jcnlwdCB2YXI6L3ZhcjpyZWVuY3J5cHQiDQoNCi0tIA0KU2llbWVucyBB
RywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0KDQoNCg==

