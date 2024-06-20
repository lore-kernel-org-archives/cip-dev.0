Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE4C27C79
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 12:43:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.46461.1718887405819477081
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jun 2024 05:43:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 45KChNEr444968; Thu, 20 Jun 2024 21:43:23 +0900
X-Iguazu-Qid: 2yAbNsrDL1aucXYdLE
X-Iguazu-QSIG: v=2; s=0; t=1718887403; q=2yAbNsrDL1aucXYdLE; m=b/y7D3XrwCFY862Bx1B2cKIeLA3O3+dR1MibBe8alzI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 45KChLQA1921109
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 21:43:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVJYv1iQK55+L9UZsVkcELzzTVZ+C0XxkhxrztwTpaSiPPHc7LbY+XXLUG3fgDGyPN3i3TKqb0QrupzEcS67aS0jKH0xyJs8hINDWU5laj67CtJRf+hcHwniuyEsyF0t0XKcNilazgNSkhG4aX3uB+ovqnbvsg1xZveIvuCzXlcc7MiMTGIYreXw+BrS38ToM1SpXdT2rWzDi9waSMREP20yKTYICMvnQdQFwgu+WBjOLqFiAUsnqPn2OfuCboFNnBBWZ7XwP6jlYa/Ig7Np+A+qQmGWyN7JvuWim9Dek945VLAQM5iZHhEGNs8pRLdFM/ZNmUjsz7v0nyBXwxQVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi8quITO7SlYSTmNuPHt/nuDvYUBdWq3tKNMveNGyWE=;
 b=VWuqoW//J4aVSyMzcREWGcywEGnU3GgPak7rOPpflubhrD1wEqQB5pu2UKIePvINFdr7FrPVPQRlIjQWaa4JKvG1atjt9YrnQq0BT6mzMyKVFf1lbQkSitD+Wq5kvkYkk1ep7jXr+8DPIwVLpM7glIb/dCCtWCVQaEIWoO55/w4m7RbXzVAy0DaxvX2CfNr2LaZrnLW4zAhdNlmlxfgOIl2OrUmH0DDLvW1/jel1uUIHc/g39A5AEcqaXzdFDASael8wxouvxxQOEzjx8bLk9zYb1TyEsmaXMjb859Air7trAtLpIkG/EVYZJ+dmMPZ1KE2YtIi1ihcSeMgwPFS8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Shivanand.Kunijadar@toshiba-tsip.com>,
        <Sai.Sathujoda@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <christian.storm@siemens.com>
Subject: RE: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Topic: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Index: AdrC1ksCFU48h0ptQR+cT3Q7rfn9dAALvlaAAAJ6KcA=
Date: Thu, 20 Jun 2024 12:43:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669C4440BEAA11AA153FB8AC4C82@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB9669288BB5107DAC76CE3DF7C4C82@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <561f6fd4-a66f-40a3-adb4-b94eb2c35ce0@siemens.com>
In-Reply-To: <561f6fd4-a66f-40a3-adb4-b94eb2c35ce0@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OSZPR01MB6694:EE_
x-ms-office365-filtering-correlation-id: 521169fd-a8c3-4519-a1dc-08dc9126905d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SmtZZHhnYU1KVHpuVzZ6cFhMY0FSUnNoSncwQW9kdCsxcC9WQXhaWFFhVjVy?=
 =?utf-8?B?aXErSE93dmhBMjVxamxvd1J1cmJEWStuRFB3cTljeVlJbEhUZVlpWFBKdzg0?=
 =?utf-8?B?cU9UTUtvdWtUcFUxSEhYbXZXdmQzMVRycXRiN3A0a3hJMkhtekpYNm9uZGJO?=
 =?utf-8?B?Z2F0UHlzUEt2dm5Mc3BWV1ZXK1E2cGNEaVBGOHNPME1nMTkzQnl0YWJtYk5k?=
 =?utf-8?B?eGQ2eHhpWUNYcmZtWXdVeUVBdWxBNS9GalNxbjU2bm1HU1VPeENEWEMxMmtL?=
 =?utf-8?B?cUVMUG5YMlkvTW51WGNBQkEyQmU1VGVtaHVIcHFCM3lPNEdyenFBNkEwdk4y?=
 =?utf-8?B?aDVMcEo4NEp0eEJ1MDVMdHppVitxZVNycDJSNW5qNDRVdytxbDNKbEhucTA3?=
 =?utf-8?B?TGsycURWQ3NQZVF2U0w2dmlXcEUxYzJ0anl4Y0NpNmFuaGowVGlWamxQOHFG?=
 =?utf-8?B?QjhaL3AxSzNuaXcrb1JLWW9lTXVhQ2ZMYndxanR5UzBleXpXZzczOVVReEZ0?=
 =?utf-8?B?QldOSk1SRDhDNkNBTzhIaXd5M0NMUFVDUUZSRVFRY2tEd0x0SDR4dEdZOXZw?=
 =?utf-8?B?V0FDZlg5REtsS2tJM2xLQmlwd3d4RjZLc2R0YTRDUzFIUndkSjlhN1lhZnFl?=
 =?utf-8?B?Q1hpQjZuNE8wd25ZN25MWW9GL3hkRDlvejNYMEYrMTQvN1gvVCtDekdZa0RS?=
 =?utf-8?B?NnBIOWhDZCtHMGhuQ0FpYzZ5Y2F5WkxURTVCZHlTOGtMbDFxODQ5MmJyOElk?=
 =?utf-8?B?ZmpBR2hTSmxHQ3BYQkhHZFc5cmRHelNTdWdBN0RsaWx0OXlZMVE0TVRybXJp?=
 =?utf-8?B?WlhzeE9FVVFOcGN0RG5uTEczTEx6RDdZblNGVVpKTXFYNE9HVDJETkxPN1ll?=
 =?utf-8?B?T09aM3ovZUQyR1FtQXNNcGxDVTcxaW95eTNMMzJjNlRZOHFybm96V2FWYSs2?=
 =?utf-8?B?bzBRTTBGZXhaNU9CUG9HZUJSUi8xU1I1ZUtYVGUwTTJxUm05UHZIV2wwT2pT?=
 =?utf-8?B?TmhxQzFTOUhGd0dqVXpHQXRGaG9WaytSY0NjMll5M3B1bHZzajNxelZNZTQy?=
 =?utf-8?B?Qk5waDlXcTZKcng3Z0N1T2hVSnpvZ25kUktHTFA4VENQNGRzTSs1Ukd1SkR2?=
 =?utf-8?B?cmsrby96cE5vOXg3SitZUU5kUkp6Wm1wZ3dPTy84ZFFubGxPTDVObmdJWHF5?=
 =?utf-8?B?MCtJOGpRNDE4eGpoS2MxYWRjb29BbGc0WG82a0s0ekJEbDJKQ1kxSEpEL2hD?=
 =?utf-8?B?RGhDWXI4OXNlVHNGWGorRStRSThHQ0tlUStPdkt0aVltem54SDZPdlp1MXQ0?=
 =?utf-8?B?NFVyZ1MvS1BPdHlXaGJuL0Faa05zenJ2clVtcDhsY3BMR2J1aVNCQytnUEhu?=
 =?utf-8?B?WXJOcWlNL01EWXQ3RFRLYzNOTHhGQUpBL0M0M0NBSVJqS0dNeHpGVk1mYXRO?=
 =?utf-8?B?QzZKY0hQbG9SRWtYUXhxeEl1ZTZuWTExblRteWM5Vy9RbE1ZbkZ3Y25nNVF5?=
 =?utf-8?B?L2w4Z0FCSHNlV1UzajRaanB6STFoZmh0TlNzZE5vSzQwam1sZ2R5RGh5OVYw?=
 =?utf-8?B?NE9GZ2RKUUEvdFF6Um9peG03clVCbVN6bUxTY2FTZFduSzlvREtMRnNNWC9i?=
 =?utf-8?B?ek1VdHVueVRJTVR5NGV6Q2FOSnlZNDVrRjRFdDFHVGorMk9KN2F3YU51NkVy?=
 =?utf-8?B?ZDE5d25XTXNLZk42eVpnUW5iRWNLT3FoTDkxbGNlVG1FNjRWcTd2bm5ON3p3?=
 =?utf-8?B?MkpjQUJ3S0s2M2U3UUU4REkyamJ3eFc2V1N3WVBWZUI2Ukkva0VtYUIxdFdz?=
 =?utf-8?Q?Xzn10CGXW+w9hnf+DIDrTZY9v9COKdV0X0fqA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TzVhVlkxcFRYeTZTZEdLcVV4eXMzcGJZRFBMbzlrT2RqZWdDc0N1ektaNHJC?=
 =?utf-8?B?WkpRM0tFZGgrcytqVUd1TStZWDljQmE2THE5d0dlekdseVpjZFlHS2R0Mm5p?=
 =?utf-8?B?cXBJNU51MHJZMDJWenNKWnVmRTVsbW0xMXA1SHJpTnEwNXdBdnUzN3VIUGJz?=
 =?utf-8?B?SXNwNURUWnU0R0UwSnQrcUVvVUZMYjM3MnFJN3dJamtLWXhUL2lTUDh1M3c0?=
 =?utf-8?B?QjB3L1l2eENsZEFHMmk3UENtb1hyM0o3V2wzUHhSb28xY082YW1ReUI1d1dP?=
 =?utf-8?B?a3gwckJpeVlDTjQ3VjY1TmZNMFB5ekx3dGY0SWlYMFVqVTJXY1FFd3M4VFM0?=
 =?utf-8?B?dHAzUHJ6TTM4NU9TTFlvREsrM0hEakt0UldqTjZBNTdGZ3E4aHlNYWd5cnBR?=
 =?utf-8?B?a1pYVmZjS2gxQ3JEZVNoOHV0cE8wbFo5a1U0YTB0R25BYmNkS0IraG9IdzMv?=
 =?utf-8?B?dUJqeVVmSnBmUE4zQTdLVkhqUHVtaGNvWDF0ZGpaOVF1WExsVDQ4VTF4QUNO?=
 =?utf-8?B?eFBaVjVzQkFRRWpDSFpVdnBrMS9XV1VVanlJeTNTRkR2NmkrRHVaVDM1emZB?=
 =?utf-8?B?NWtNUVpOeDJOTUdWeldoNVJXWFJmLzZTdTZLWlUxNUhYcjZxcDZUSEpkY3ZO?=
 =?utf-8?B?UEpFdnErRUVpVUljYUpHSlh3WlhKTTkyeUNvMStNVDZUMEdra2l3RlQzajVj?=
 =?utf-8?B?dFJnU3ozWDZiNXVtQ2ZjVkhNYmRZZFZTRVZmV2lLaU5Mc09JL3VkdWxjSVp6?=
 =?utf-8?B?aXZjL2JweS93a1JzaEN4Qk5wdCthaU9UWUVJMVFRR09tQkJJT0d6c3ZweG1v?=
 =?utf-8?B?aG40eG5RaGZTb2lYQ2xsVzNNR3l4Y2lzQ2NoUTFIY1hsYm56ak01a3hCV1Uy?=
 =?utf-8?B?L2c4NXBkMW1HY1p3OGF2WkovUUx2MnJwbExGaDFKbkpzc0FpT1V6V3FzQWM1?=
 =?utf-8?B?RmcwckRZdFFoZUhPdExNS3JSNHVtVGFTMFZxdXNacnNqTFJNL2x4b2x1VmR1?=
 =?utf-8?B?d0x3OHhXOE1VczhyZGtkNHlQRmN6VG0xWWlNbGdrT0EwQ1J1LzlmWTlzOWxK?=
 =?utf-8?B?VldwOFBzMTBWQWRsZyttUkFIRWhGc09JTjF0aU5xT3d6dDNrQklwREQ2SXYz?=
 =?utf-8?B?b1lGOE03VjltVmFFRE5KZ01NOWlsODlzcS9SRENpRDVFTjlEZzZOaEhYV25I?=
 =?utf-8?B?TkRxcWFLUEdLeEFQTmZtQzlPdWFpQzY0UjQrRHJHQjU4RVBkbktlRHoxUXhw?=
 =?utf-8?B?OWFGUEczK000ZFU1U3I3aStybHZQTkFtY2ZYV1Mrb0ZUa2dLQ0YxMEFQTE5l?=
 =?utf-8?B?Rjg1SkFXc211aGFPTEhhMWgwUEgrMThFTUJ0dFREVU5ZdWJZSHpkamE2NVA5?=
 =?utf-8?B?UG1ON20xK0ErV0tYVCtmZjFOVzU4M0xQcW44ZElOVGpFZEh4Z1pLSnl2THBP?=
 =?utf-8?B?WkJOYjlmZm5CemtMdENGSitiY0VkTTZXYWNKWHo4MXZqMlRoMnc5YzIxbUhY?=
 =?utf-8?B?S0NtTDVsTkNEL05xbXBoeC9WK202cHA4NW43UDdDcXdVSUJiS1BmdFg4M1Y2?=
 =?utf-8?B?dFZpdlNLNTdqN2h2TDFQQnJWSnFkdVNyNmRVZlZ1aWNTSTBGNUVhN3ZJZ0l4?=
 =?utf-8?B?Nkw5dnYzYlIrWndnanJVV20xZ3dtUTdQTGR2YWE3cHMvZ1AxOFg0dE1tVDVQ?=
 =?utf-8?B?STdFdU14QkdHS3IyeHFFZUFzZStwQnMzY3FJeklvcmFMaFB5ajhib3V0TkQ3?=
 =?utf-8?B?UEFnSGpnOWU3R3RDQ3RkcVJseUMzTjdCMFViQ1Y3dityMXJWYVg5K1hvbUF6?=
 =?utf-8?B?ZzRrZGkwSTVpNUY4UlF1b2xiV3RpZm1QMEFQejlWZ0NFUjJGQW1OeThuRzIy?=
 =?utf-8?B?OHpVUmMraGhlZUtQUnV6V0xxNWsvWjJ5MGtzaTgxOVdvQmZNcVBzS1FudVJj?=
 =?utf-8?B?K0NQcmI1cDJTd3FLQkZYRldlTWhkcVBRZXIzY2tDdVJuSE93SlZienM5UUlr?=
 =?utf-8?B?K0M0L3BVNHI4UWhTSHdoa1hWZ1p4ZnRPbkxCVk5HWUVvelgvbk9HTTkyS0sy?=
 =?utf-8?B?MVlhdk9OYVRyZHlQN2NOQnpGWmJSLzVLbVhNSm1mWTc3MTI3cVRsNnNES25V?=
 =?utf-8?B?UVhuTVgxWFQyWWxMQXFlKzVhUE9WZHJ6WTlwRXR2aFprV09NakFwVWgrV2x3?=
 =?utf-8?Q?sHYqgiitjFB+UJvctnWD0mQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521169fd-a8c3-4519-a1dc-08dc9126905d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 12:43:19.6428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTd+4++f8rjV4KwIl/0de1jKqBwqQ0ouVXXtQW+7q/pcpxci4hLgj4DoJcFwpPb0t8tJ5RgOre/rwMKB8nNzjLKYxx+OyIbBeEq+zKmJsj4EZTCLWfTDoNr5GnWMgSqv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6694
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jun 2024 12:43:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16305

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIEphbiBL
aXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KU2VudDogVGh1cnNkYXksIEp1bmUgMjAs
IDIwMjQgNTowMSBQTQ0KVG86IGJhbGFrdW1hciBhZGl0aHlhKO+8tO+8s++8qe+8sCBURVVSKSA8
QWRpdGh5YS5CYWxha3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXBy
b2plY3Qub3JnDQpDYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGlu
ZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPjsga3VuaWphZGFyIHNoaXZhbmFuZCjv
vLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hp
YmEtdHNpcC5jb20+OyBhc2hyaXRoIHNhaSjvvLTvvLPvvKnvvLApIDxTYWkuU2F0aHVqb2RhQHRv
c2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g77yk77yt77ylIOKX
i++8pO+8qe+8p+KWoe+8re+8sO+8s+KXi++8re+8sO+8lCkgPGthenVoaXJvMy5oYXlhc2hpQHRv
c2hpYmEuY28uanA+OyBDaHJpc3RpYW4gU3Rvcm0gPGNocmlzdGlhbi5zdG9ybUBzaWVtZW5zLmNv
bT4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gUmVnYXJkaW5nIHN1cHBvcnQgZm9yIFdGWCBiYWNr
ZW5kIGZvciBzb2Z0d2FyZSB1cGRhdGVzIGluIENJUCBJbWFnZXMNCg0KT24gMjAuMDYuMjQgMDc6
NTYsIEFkaXRoeWEuQmFsYWt1bWFyQHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+IEhpIEFsbCwN
Cj4gDQo+IFRoaXMgaXMgcmVnYXJkaW5nIHN1cHBvcnQgZm9yIFdGWCBiYWNrZW5kIGZvciBzb2Z0
d2FyZSB1cGRhdGVzIGluIENJUCANCj4gSW1hZ2VzLiBJIGFtIHdyaXRpbmcgdG8gdW5kZXJzdGFu
ZCB0aGUgb3BpbmlvbnMgb2YgdGhlIGNvbW11bml0eSBvbiANCj4gaG93IHRvIGdvIGFib3V0IHdp
dGggdGhlIGludGVncmF0aW9uIG9mIFdGWCBzdXBwb3J0Lg0KPiANCj4gQXMgSSB1bmRlcnN0YW5k
IHRoZXJlIGFyZSAyIHBhcnRzIHRvIHRoZSBXRlggaW50ZWdyYXRpb246DQo+IDEuIEhvc3Rpbmcg
dGhlIFdGWCBzZXJ2ZXIuDQo+IDIuIFN1cmljYXR0YSBjb25maWd1cmF0aW9uIGluIHRoZSBDSVAg
SW1hZ2VzIHZpYSB0aGUgc3d1cGRhdGUuY2ZnIGZvciANCj4gY29tbXVuaWNhdGlvbiB3aXRoIFdG
WCBzZXJ2ZXIuDQo+IA0KPiBBcyBmcm9tIHRoZSBkZXZpY2Ugc2lkZSwgY29tbXVuaWNhdGlvbiB3
aXRoIHRoZSBXRlggc2VydmVyIGlzIGFscmVhZHkgDQo+IHN1cHBvcnRlZCBieSBTV1VwZGF0ZSB0
aHJvdWdoIHRoZSBzZXJ2ZXJfd2Z4Lmx1YSBtb2R1bGUuIFNlZSBbMV0uDQo+IEhvd2V2ZXIgdGhl
IG5lY2Vzc2FyeSBzdXJpY2F0dGEgY29uZmlncyBpbiB0aGUgc3d1cGRhdGUuY2ZnIGZpbGUgYXJl
IA0KPiByZXF1aXJlZCB0byBiZSBzZXQgd2hpY2ggaXMgY3VycmVudGx5IG1pc3NpbmcgZnJvbSBp
bWFnZSByZWNpcGVzLg0KPiANCj4gQmFzZWQgb24gQ0lQIENvcmUgd29yayBncm91cCBtZWV0aW5n
cywgSSB1bmRlcnN0YW5kIHRoYXQgdGhlcmUgaXMgDQo+IGFscmVhZHkgYSBwbGFuIHRvIGhvc3Qg
YSBXRlggc2VydmVyIGZvciBDSVAgcmVsYXRlZCBwdXJwb3Nlcy4gV2hpbGUgDQo+IHRoYXQgaXMg
c3RpbGwgaW4gdGhlIHdvcmtzLCB3b3VsZCBpdCBiZSBhbHJpZ2h0IHRvIHVwZGF0ZSByZWNpcGVz
IHRvIA0KPiBpbmNsdWRlIHRoZSBuZWNlc3NhcnkgY29uZmlncyBuZWVkZWQgZm9yIFdGWCBzdXBw
b3J0IG9yIHdhaXQgZm9yIHRoZSANCj4gc2VydmVyIHNpZGUgdG8gYmUgY29tcGxldGVkPw0KPiAN
Cj4gVW50aWwgdGhlIHBsYW5uZWQgV0ZYIHNlcnZlciBzZXR1cCBpcyBjb21wbGV0ZWQsIGhvdyBh
Ym91dCBpbmNsdWRpbmcgDQo+IGRldGFpbHMgb2Ygc2V0dGluZyB1cCBhIFdGWCBzZXJ2ZXIgYW5k
IG90aGVyIGRldGFpbHMgZm9yIG1pbmltYWwgDQo+IHZlcmlmaWNhdGlvbiBpbiBhIFJFQURNRSBm
aWxlPw0KPiANCj4gV291bGQgbGlrZSB0byB1bmRlcnN0YW5kIHRoZSBvcGluaW9ucyBvZiB0aGUg
bWFpbnRhaW5lciBhbmQgdGhlIHJlc3QgDQo+IG9mIHRoZSBjb21tdW5pdHkgb24gc3VjaCBhbiBh
cHByb2FjaCBhbmQgYWxzbyBvdGhlciBpZGVhcyBvbiBob3cgdG8gZ28gDQo+IGFib3V0IHdpdGgg
dGhpcyBpbnRlZ3JhdGlvbj8NCj4gDQoNCldoYXQgYWxsIG5lZWRzIHRvIGdvIGludG8gdGhhdCBj
b25maWcgZmlsZT8gSnVzdCB0aGUgYmFja2VuZCBhZGRyZXNzIG9yIG1vcmU/IFdlIGNvdWxkIG1h
a2UgdGhhdCBhIGtjb25maWcgdmFyaWFibGUgc28gdGhhdCB1c2VycyBjb3VsZCBlbnRlciB0aGF0
IHZhbHVlIGJlZm9yZSBidWlsZGluZyBhbiBpbWFnZSAoYW5kIGxhdGVyIG9uIGRlZmF1bHQgdGhl
IGFkZHJlc3MgdG8gd2Z4LmNpcC1wcm9qZWN0Lm9yZyBvciBzbykuDQoNCkphbg0KDQpbQWRpdGh5
YSBCYWxha3VtYXIgXSANCldlbGwsIHRoZSBjbGllbnQtaWQgYW5kIHRoZSBzZXJ2ZXIgKGJhY2tl
bmQpIHVybCBhcmUgdGhlIG1hbmRhdG9yeSBvbmVzIHRoYXQgbmVlZHMgdG8gZ28gaW4gdGhlIHN3
dXBkYXRlLmNmZyBmaWxlLg0KDQotLQ0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhw
ZXJ0IENlbnRlcg0KDQo=


