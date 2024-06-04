Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5F1C27C53
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 08:25:59 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.74])
 by mx.groups.io with SMTP id smtpd.web11.16330.1717489558081330732
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jun 2024 01:25:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ZhER8KAp;
 spf=pass (domain: renesas.com, ip: 40.107.113.74, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOmpLJdfeP2anlaHfu1+w3Ot+AASYp3zWDE6P/1vhR3zUuGj38AljTZupvIX+ay6MnPz3o2BP/P4h6BxrGYW/O93b/w+8KoKcIJpmt1tihEIVCIV4uE1wm17fysJbmJcZRWNVpIQSHGTcYYvHVBLsHKDcqUx7jeHtVmd8YFkFYWVoQQAyZ+Jq31p+wcJKEcazweITHPU+fPesijL2mtfzQrHdx8VpzFgezzmHcxaccZpjMibClqL8NVG92uCyWaz3AMLJrK+hpmB/5HfF/IjJwz5dhdwo8MBNWdann3TtisVF7r2nB4Bla3k5PFmxaofRrNeeXkfVNm6xglmPtT7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVoCadItDHN6ICtsSHajb9Wb0pNeyRsK3tvXwLYty3U=;
 b=BH50yEvCgmA/kVzsinAMGsb80feNvX24l2HqmWBvEnt/rajK5BJBuBdjhGBK7zipY6DPp9ZlZeTCapCAwwdD+MHPoENIrWDABDHrByjOYx2IVtoAcLGUc3Iwi8W7dVk3nILc6t+BK8siZed++EkgsyyT5B8egV4xVzgjlKpvX+YuZLTBMzV2PEk1EuqocGzTALZUVt1NEunWVIpkGlBfoPjvQCGFntCK2LmmVq128GGXt8pvMRMCu4k3ImmhDuM8RiWTlt9sVQLgxh3mcmajnFJzv5gPt8tCnxls0OOqJa3D1d2/4Ab5O9254++iWSIVLe2hOI3cH4k96hF/hfenvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVoCadItDHN6ICtsSHajb9Wb0pNeyRsK3tvXwLYty3U=;
 b=ZhER8KApPL1/Obpbb8rfLif4TahnxFqmX4IsriFA8EdbfqQ8xPNXqfLCTLJuUjeb+hKFtp5HSx9LdcXj+FDM46YhtV0hYuXpSnmaDIRwyl8Ljjz4FxYbHvU9xXF39NVJl//kX19S7KSATcX3v4gTpP/r9xfkd1hfdv258XD+81k=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OS7PR01MB12129.jpnprd01.prod.outlook.com (2603:1096:604:25e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 08:25:52 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 08:25:52 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core 3/3] .gitlab-ci.yml: Add test targets
 specific for CIP core functionalities
Thread-Topic: [cip-dev] [isar-cip-core 3/3] .gitlab-ci.yml: Add test targets
 specific for CIP core functionalities
Thread-Index: AQHatYUFVwBYHOS6Zk+qXNeGkq/RIrG1wUKAgAGERwA=
Date: Tue, 4 Jun 2024 08:25:52 +0000
Message-ID: 
 <TYWPR01MB1186232720D9F995D35E26045B7F82@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <20240603070920.2942859-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240603070920.2942859-4-Sai.Sathujoda@toshiba-tsip.com>
 <441b9fa4-27d2-48b1-8c8c-9380ad839ccc@siemens.com>
In-Reply-To: <441b9fa4-27d2-48b1-8c8c-9380ad839ccc@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OS7PR01MB12129:EE_
x-ms-office365-filtering-correlation-id: f4c7937d-52af-4b2a-6da0-08dc846ff259
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aWVOVzlEbVFnSkE5ZE53K284cmJMOVFUT09yZTRRRll5azZLcmowSlB4MkVE?=
 =?utf-8?B?RmV5aEQzcGZtbi9qZWwyTDJUWGR0QVdaV0EwbFYwditmNUJ1VUFQQXNXNWkr?=
 =?utf-8?B?OUJZRUROaGp6dE56Q2pwcnFOMUJhN3cxYmVCblhTUU1GK1Uyd3RDU3AxQ3hh?=
 =?utf-8?B?YXdkQnVERW1ZMENzSTlxR01BQUIyUGp3ZlhWaWNuUk9mVWh4YzZWd3g5b0pM?=
 =?utf-8?B?YktEY081MElQU1EvdG9aWVFBa2RwdGwxeVRnb0FYemluQXF6RWN2czM2QlRq?=
 =?utf-8?B?Rmc2WENzNkhyem5lT0Nsa2VYa2ZCcmduTzh1N1JrdzNLRW5LS0cwVHNSSU9S?=
 =?utf-8?B?dndsK0ZGR1RXNzY2OWtNaVVwK0UxYktRN1Y0MUwyN293cHRuaWg4SlAwNDNM?=
 =?utf-8?B?TDBycmtNWE9FME1TQ1lvVm16ZTlZZ01BK3A0UUxXU1pDWURPVEJNRmdRU1dy?=
 =?utf-8?B?NGR3OUQxQVFCMXB5dkdFMUZOM0tYdHB6bFFESmp0SlUvdVA2eHNFQkhGR2Rs?=
 =?utf-8?B?YzBGWFlvYTBkNURPNEJ4eHM5U2w0czQ0aGU5NVZrTmdvOHYyREN0Z0YrTm5Q?=
 =?utf-8?B?RHo4QWxxaGNSei83dXN6RHJXMlVLYktlanBoYTRxWnpXTVpERmlmQmdTUFZL?=
 =?utf-8?B?R21ta1dCa0Jsd0lJbUhzcUt6dHZIRWpqU1ltdXFHNitiR05oNm9RSHhNbTlw?=
 =?utf-8?B?YkczNWVNdW1sa3hLOEZTTS9ydGJuUjVEdmtMWFhVakV1dUZrcm5SVTlqaVpz?=
 =?utf-8?B?aWFYU1JSQk9FZ1Y2a1hnaStvbGJUS09iSnhCMEVHMW1tc2lFbUVxeXRDMWFG?=
 =?utf-8?B?QzBjMUFUVE1BOVZxNjJabVVUNUw4Y1NCZ2RudGc3RkV2bG5kdjRzaGM4cDA0?=
 =?utf-8?B?WEpEUDNOVWRJd0tQTXRvT0tMcVpMR2lhdThUdUFQUStRellJNlU1MEdaMGdS?=
 =?utf-8?B?ejk0VWtvNHZ1MkVXc2ZmVDM4ME11OXlDYUtheUEyOUptYmpCdi93cVNsNW9P?=
 =?utf-8?B?ZU9mdEZSYldGNW1BVHhmYzhZMCtaNjBmNUlHcEQwbFViT1ZDRENYRkpETVlt?=
 =?utf-8?B?TUw2UEw4S21xb081YVhXZzhlVzFjSkxkM2dYektQdUtMaTJ4T3hQV2FZT1Qx?=
 =?utf-8?B?RW5CVklRV3IvUzF0eGhuY2NBcEFnbVlNNDNtWFhrMHVDWXZHR0RmektOMklo?=
 =?utf-8?B?T2NLLzQ1aUFwN0Y0VjVNd1B0czRqRnowZzIwdVNJNEtjdGMyakFSWnVYZlg2?=
 =?utf-8?B?eE52UjJReTVoYWh0dHhCQUtaVUsvTWlyamI4Tm54dG96emVlbENLaUNxcVhP?=
 =?utf-8?B?K0RWWGJyS2l2MEgvTGpQdmRLUTVsd2xlTmRpT0Z0K2twbmY1ZFVIRkhMMnZj?=
 =?utf-8?B?ZHNRWDB1YjNiczZQblNrSlJYd0dpSDFwTVE4cGlpTjhmR3VjblEzVG9tQXBh?=
 =?utf-8?B?bjhydVdHSjZwVXM3eVVzQmd5VlVOVTdVbWlURGtUb1RKcElNYm5CWGtBeXdV?=
 =?utf-8?B?Z3FMUkhYMUx0MkQ2UmdUR3ZsdHNnaUdUZUVvOUJ5M3k2dVRJL240RFFrZC9X?=
 =?utf-8?B?c2JNUFE2MG8zemRqbUFtcDR0NjFsclhadmNhV3VNQUMwM1k0K1N6SGljc2V0?=
 =?utf-8?B?aXhUZWhEdlg5WUxBTUVxU3pwd0trY3hsYmliUnM0bGdicFd6eC9yWFAzb1VS?=
 =?utf-8?B?YkZHbFNYNDg2QjA5V01tNnlZeFpUWW1RYUpmem1aZlozeXd0S1ROUVR6SmM0?=
 =?utf-8?B?aUlVZ2dieWF0MC9uWjZ1bWViMnZlM0ZDNW1YdUJRMGsvdXg4OUFyNDB2TzJC?=
 =?utf-8?Q?s/HnECRZwtmscIeOo6+iiPx6WFRG/J1o1SKV8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dFRlWGYyYWM5SElFNXN1YUk4NGFKUm9EZzkwV3FKcHE2OGVyV3A5VEEwOTQ1?=
 =?utf-8?B?UWgxcjJoa0s5VDVXYzJsekVUWGRSY013eE1EQ3JNZDV3RksxY3ZKR1B0L1hv?=
 =?utf-8?B?MFZpd3B5MnJQVEVTYkszSGZndnBYMkJBOEJ4Tkc1akV2NG4wU1VtLzZ2OGY4?=
 =?utf-8?B?dkZjU3ZzNHJvNC95RkFCb2ljRGJhMENDZ1g0bmdaMThwb1JTTStkeURWWU5K?=
 =?utf-8?B?eW55cFhPRzZMaldGc3pTNDBVL2xXREt0WlFuYko4ZFh4cUNWdk10dFRGV0Mv?=
 =?utf-8?B?em5VWmdxdTRlUGRYNWZtTWYyQW04Vm52NSt4QTgzaXBZOGdVRXB0WVNHNVd1?=
 =?utf-8?B?SjlIb00xTXdWZ0FoL3JEUzZDekpOeWdZN0NJRW1pbjlYdWZHakZicFFmZlh4?=
 =?utf-8?B?Y1pFWUZ0SEVBa3lqWmIzLzhXYzNNSmVoc3RZOGpQd3l0bWNrWUlaOVZBQ0tu?=
 =?utf-8?B?WGM3eXpERkU0RUxSUUx3VjEyUWxhdFpnakhqN1k5THlWdkZDdXhMQ3JMYmx5?=
 =?utf-8?B?dldSdy9DSmFJcGJzcW1ZOEZiSG1iTHhFcmZjZTNiUFVuclZVVDFmbkpGYWFP?=
 =?utf-8?B?ZDJFNEpjSVBXK1AwcmNoVWZaaE1FVGNEaE00SWlkTHZkbUFlYXdjTDc0QjBZ?=
 =?utf-8?B?LzU4eVcxa2xjZnFBODhneWVYR2l5bEZOK0hQWnZFY0Y1VXF2K01qdmIyTTkw?=
 =?utf-8?B?TGtLY0l0bGFlc01IS3NqMHdCNENPSE9vRWYyL0JOZHRuOUEyZkg1NCtwTUV0?=
 =?utf-8?B?Vkw1amt1YmtNbDRJeHllVWpTYTN5S2RGNCthOWJwdW4vYmp2YnhDUzJhQU5p?=
 =?utf-8?B?azZoTTQ5NEtNYk93MDNQd2tOSkhjVEgxM3RrK1NJZ1RyUTRJZ1kzNXVJQ2lx?=
 =?utf-8?B?eVNiYkhHMzJsbWhnN3RXWFd0a1N2RzIvWUtYSnNlcFlJSitIdUhNUDlkZWdk?=
 =?utf-8?B?NzM5NW9mdER5TUVUL0ZhclI3aUw3QVhTcVlCSzBFYXJxN1N5MFFMRllPa0FJ?=
 =?utf-8?B?RzR0MENnc2E5RFF2SnJzaTFsd3FmamxxVENlS0F2VVpOaEpjdVRCMEZWZjFv?=
 =?utf-8?B?Vlp1dFg1RG1xTXpYOTc1VEI1cWliOTdWUjlYMHlYVFRJSktYdWRLdU1YOFo1?=
 =?utf-8?B?d1dhSjMyS2lBc0dic3JjOWtPeWRZWHRWVHBvd0dxb2pkeW5pQWlMaTliRTFL?=
 =?utf-8?B?RzR4amR2cFNrTmRmY2s4cWdzNFlvR3c1S0ljUHpyQ2hBUVhNVnZ5WmxhaE9B?=
 =?utf-8?B?eXlEYkFvejJDMmR2MTlMSjVTdEIxM3BuK1BoRE11U0h0UWs4RDJSMjVZT3Ny?=
 =?utf-8?B?NzZ4MXBlVW14dk1QVGhrbUc4N2lPM2cxSWU5YWJWeFhBMG9vZEpJdzJVcGxY?=
 =?utf-8?B?UlRuMUhjY0RNZ1Z2Zy85SnFSbFdwTmlLMi8yQVh4dEJEbFhGTWI4d0pNa00w?=
 =?utf-8?B?ZlR5dnVtaTM0cW1XSHJwTm0yNlFkTXJtaTdDRUtMZHkvTlBYaUNzYVkwV3hC?=
 =?utf-8?B?R1VzQ0hEck9mS3dyNmJrTXgrNVAwcFdOcEFQeC93NWtJcDBhSlpKcWUyWXVY?=
 =?utf-8?B?VjJDVDhaeFdzbkg1M0l0MFhQWjVMbFVieXVGQ2tTcEc3K1BJNTgreXYvb3FL?=
 =?utf-8?B?dzlWU2dHYjlhYlpRV01nZlZVTHc0RDVOeGxTd3ZvT3J5QnlwVktyQWNzT0Ry?=
 =?utf-8?B?eSttOHpCUmc5TVFlSllWM3VRWjNDemlYckswWlQ1amcyS0tBb21pa1B6SmJh?=
 =?utf-8?B?dVlTZEZLSHp1RXdTb2ZFTU1MeFBQYzdPaE4xTFFTM0lTRmUrWTZnL0FyWmcy?=
 =?utf-8?B?elppeE9MOE9WbzlrMkV2eGt3WnRVWEVlT083aEY1eURqYmhwaXBKd01iemVJ?=
 =?utf-8?B?cDQya2w2akRrSkIvNzBPV3Y3MDhQdEE3eTB1ZGVmTzIybUliMzVuMDAvV2R6?=
 =?utf-8?B?ZFFWZ2hhUWM4RDgzK01LekRiaU5aR3pIeUE3VDIzWHFhVktYRVdSUERiQmtO?=
 =?utf-8?B?NkExWUhDK3pYSFRvUVp4RkVGb01YWUxFUnRTalpYRzRWTEplOHFkaTMxNU5q?=
 =?utf-8?B?V2VNbnh4cEpWclBZS0xuR21kQzVzNkJSODlEdnhTQXQ0QU02OHVXeWMyU1Q3?=
 =?utf-8?B?NTk2L2NFTTQyaGNrMDVPRmJQcTBzR1lib3J6UVlGT01nV3dQSnhpMmlrWEMw?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c7937d-52af-4b2a-6da0-08dc846ff259
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 08:25:52.1930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yitXEakaNh+zVS0ktQcuuogSg2F16SGte23yNZhHUnLwI05HCCjZvdOCnfCkcuLUjYPqJVU8WRmQ2Oi6aR3ys3WHCGRAbwMwX5ZFtA3OSTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jun 2024 08:25:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16102

SGVsbG8sDQoNCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiBCZWhhbGYgT2YgSmFuIEtpc3prYSB2aWEgbGlz
dHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAzLCAyMDI0IDEwOjEyIEFN
DQo+IA0KPiBPbiAwMy4wNi4yNCAwOTowOSwgU2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29t
IHdyb3RlOg0KPiA+IEZyb206IHNhaSBhc2hyaXRoIHNhdGh1am9kYSA8c2FpLnNhdGh1am9kYUB0
b3NoaWJhLXRzaXAuY29tPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogc2FpIGFzaHJpdGggc2F0
aHVqb2RhIDxzYWkuc2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+DQo+ID4gLS0tDQo+ID4gIC5n
aXRsYWItY2kueW1sIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
LmdpdGxhYi1jaS55bWwgYi8uZ2l0bGFiLWNpLnltbA0KPiA+IGluZGV4IGFhYjU1YmUuLjBhMjJh
M2YgMTAwNjQ0DQo+ID4gLS0tIGEvLmdpdGxhYi1jaS55bWwNCj4gPiArKysgYi8uZ2l0bGFiLWNp
LnltbA0KPiA+IEBAIC0zNTgsNiArMzU4LDM5IEBAIGJ1aWxkOnFlbXUtcmlzY3Y2NDoNCj4gPiAg
ICAgIGRlcGxveTogZGlzYWJsZQ0KPiA+ICAgIGFsbG93X2ZhaWx1cmU6IHRydWUNCj4gPg0KPiA+
ICsudGVzdC1jaXAtY29yZToNCj4gPiArICBzdGFnZTogdGVzdA0KPiA+ICsgIG5lZWRzOiBbImJ1
aWxkOnFlbXUtYW1kNjQtYmFzZSIsImJ1aWxkOnFlbXUtYXJtNjQtYmFzZSIsImJ1aWxkOnFlbXUt
DQo+IGFybS1iYXNlIl0NCj4gPiArICB0YWdzOg0KPiA+ICsgICAgLSBsYXJnZQ0KPiANCj4gQ29u
Y2VwdHVhbGx5LCB3ZSBzaG91bGQgbm90IG5lZWQgbGFyZ2UgcnVubmVycyBmb3IgdGhlc2Ugam9i
cy4gRG8gd2UNCj4gbmVlZCB0aGF0IGZvciBvdGhlciByZWFzb25zLg0KDQpBZ3JlZWQuDQpQbGVh
c2UgdXNlIHRoZSAic21hbGwiIHRhZyBmb3Igam9icyBsaWtlIHRoaXMgd2hlcmUgYSBmYXN0IENQ
VSBpc24ndCByZXF1aXJlZC4NCg0KS2luZCByZWdhcmRzLCBDaHJpcw0KDQo+IA0KPiA+ICsgIGFs
bG93X2ZhaWx1cmU6IHRydWUNCj4gDQo+IFdoeT8NCj4gDQo+ID4gKyAgYXJ0aWZhY3RzOg0KPiA+
ICsgICAgbmFtZTogIiRDSV9KT0JfTkFNRSINCj4gPiArICAgIHdoZW46IGFsd2F5cw0KPiA+ICsg
ICAgZXhwaXJlX2luOiAxIGRheQ0KPiA+ICsgICAgcGF0aHM6DQo+ID4gKyAgICAgIC0gcmVzdWx0
cw0KPiA+ICsgICAgcmVwb3J0czoNCj4gPiArICAgICAganVuaXQ6IHJlc3VsdHMvcmVzdWx0cyou
eG1sDQo+ID4gKw0KPiA+ICt0ZXN0LXFlbXUtc2VjdXJlLWJvb3Q6DQo+ID4gKyAgZXh0ZW5kczoN
Cj4gPiArICAgIC0gLnRlc3QtY2lwLWNvcmUNCj4gPiArICBzY3JpcHQ6DQo+ID4gKyAgICAtIHNj
cmlwdHMvc3VibWl0X2xhdmEuc2ggc2VjdXJlLWJvb3QgJHtDSV9DT01NSVRfU0hBfSAke3JlbGVh
c2V9DQo+ID4gKw0KPiA+ICt0ZXN0LXFlbXUtc3d1cGRhdGU6DQo+ID4gKyAgZXh0ZW5kczoNCj4g
PiArICAgIC0gLnRlc3QtY2lwLWNvcmUNCj4gPiArICBzY3JpcHQ6DQo+ID4gKyAgICAtIHNjcmlw
dHMvc3VibWl0X2xhdmEuc2ggc3d1cGRhdGUgJHtDSV9DT01NSVRfU0hBfSAke3JlbGVhc2V9DQo+
ID4gKw0KPiA+ICt0ZXN0LXFlbXUtSUVDOg0KPiA+ICsgIGV4dGVuZHM6DQo+ID4gKyAgIC0gLnRl
c3QtY2lwLWNvcmUNCj4gPiArICBzY3JpcHQ6DQo+ID4gKyAgICAtIHNjcmlwdHMvc3VibWl0X2xh
dmEuc2ggSUVDICR7Q0lfQ09NTUlUX1NIQX0gJHtyZWxlYXNlfQ0KPiA+ICsNCj4gPiAgY3ZlLWNo
ZWNrczoNCj4gPiAgICBzdGFnZTogY3ZlLWNoZWNrDQo+ID4gICAgbmVlZHM6IFtdDQo+IA0KPiBK
YW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj4gTGludXggRXhwZXJ0IENl
bnRlcg0KDQo=

