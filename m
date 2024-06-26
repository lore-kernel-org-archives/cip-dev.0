Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7781BC27C4F
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 11:20:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.23792.1719400807041211956
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 04:20:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 45QBK38a2401916; Wed, 26 Jun 2024 20:20:04 +0900
X-Iguazu-Qid: 2yAbrn6vGrsCNszMCf
X-Iguazu-QSIG: v=2; s=0; t=1719400803; q=2yAbrn6vGrsCNszMCf; m=4v6NV1l/oS+rWDKQCzict96aELVRWtszrU3tW7azrZc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 45QBK1ua393191
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 20:20:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbtqBX5ZdqypZlOUdaeBbwuvE2jnX+UHF8jW1BhTAeXED7CO9bJogmLI0g1Bt2jEmtnZ5tTWg82o36XoST7pddCFqa6SjlWKZUjkRiG7tfms/9I1AXgX2/41i3v7QKKsKeFt6+ZWh7slbgj52k7IckyX6b5cGpaG5aj+lD6DaCMmM1+JvDgrZUnIVrmTe5Yp+TAE57voSKAIxlzWN+kmbsqcFIR1BKyEmd0OwcaLHCMSq24UKGeTajGrzUJKn/F92cKvmE703pzzkRgWfGtsYhxV5XkV53kert3FQTg0LTRjG494W/LSmvxuRKpxHJdky7ZrsVhCE3EQIb6wjG3YAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwXOb6p7OGkM45ro3hkDs5KuljndN9+6+fYmORXYUJ8=;
 b=cVuu6y/a9amjFi4/lAcQdcMiOh+E+MBqmS5LlSFrTC2P5hSsXZ86eGmAKEzH8SFOmA3BY6IIL4aaHoH/1sWDP6Y2QfcjqzQJztUvK2ZODzi4Fdzv8ssgb5L0lmFZ/Gdbym270Jnux/Z/CHeFPgdsAZ7IpJCP/I9Gza4Umt9rRZKg419+l8AwzvPIC8sR1ur96VvoynS1fV7vJdqhzW+fNDIE0AYTo2sHydaFmQvHz0THNldTpNrlGY2yYSLEa+/LwVK4exq3n5mZEbJS3iImDp094tSdc/tqs3tiLk/viM7dsSbCzNKST6PKC+dM1zuK+hK6+EWAUkCkhg51vf7jaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Shivanand.Kunijadar@toshiba-tsip.com>,
        <Sai.Sathujoda@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <christian.storm@siemens.com>, <jan.kiszka@siemens.com>
Subject: RE: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Topic: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Index: AdrC1ksCFU48h0ptQR+cT3Q7rfn9dAALvlaAAS1PbFA=
Date: Wed, 26 Jun 2024 11:19:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669740DA683EAE4C6E8ADBFC4D62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYTPR01MB10952:EE_
x-ms-office365-filtering-correlation-id: dd04771d-fff1-4103-ddef-08dc95d1ea65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info: 
 =?utf-8?B?L0pwY3dFQ0JIV252dkx6ZjE3S2o3UW91eTYvY1U5VTVHVDhhOWFOd1ltck1m?=
 =?utf-8?B?YTc4SmI5OVQ5RTBtSGZSMndnWmFYcWQ0ODV1MWRXTjZOU1ZwZXcrRWxYbngy?=
 =?utf-8?B?VCtuS2FEMk92REhnNUQzZkM5V09oUndIZXllbnpOWnMrQzlFN3JSSkQ2Y3lT?=
 =?utf-8?B?TjVZR3NWSEZRY0cvbEJGY3ZScnFWZ054ekNwTExaYVY1aFg5T2FVeHpVZlls?=
 =?utf-8?B?NUNqTllubFJOMml5SmpoMHFsS3hCWmp1cE00SURTMS9OYTdBT09MMDJUY1lY?=
 =?utf-8?B?QnBGWUVHcitBOUxQQ1NOMU9CNEpHcUhIemw4ZDhkb1VON3hWeFdVRkYxMWg2?=
 =?utf-8?B?SytHTVhsZ2xtMGdNN1FWaE00bkVQNnI2RFpscCtQN1lrZTM1QWRtU1drTTVw?=
 =?utf-8?B?aUR1QitFWUhJcVhtOEF5dzVVUlZDYlR6alFnZ2QrVXlkUWFwTWdhSUUwUVZl?=
 =?utf-8?B?QkxJQjdVY1ZXQ09mcGZIV2tqVGQ2b2Q5Mno4aGFkeGpaUDR4L0c2V2FaNE96?=
 =?utf-8?B?ZklmVm1yRUMwZGh1Z2lYTFVFR0xYN0w0T1FTemlGeTQ2c2hYa3RtYk9iVnRh?=
 =?utf-8?B?ZkQ5c1U3ZVp2Wk1RNlFHTG1udFU2dHlCWnZTanIvQnAwN25nNkk0NHZySlZI?=
 =?utf-8?B?eFBvdXZOT2pMdTl0ZE96WlR2NnZqNkFIc0sxZDVPY0Q2MEJPWlFYTTFUYXo2?=
 =?utf-8?B?b3hwSlBTaHRqUERORnBJTXNuWGdjS29QTjE5ditlaWh0d3BKam52aTZ4bVRz?=
 =?utf-8?B?emxrQXl5Rmk2ek1rZGR5RmpVU3Q2Vm91VzhLS016UUE1TTZGM3BBRTJhV0o1?=
 =?utf-8?B?NVFZSUVXNFNiZk9uLzBuemZTRHVDZzM0ak9qZEk1N0ZuaTF2KzcwR3VBZEha?=
 =?utf-8?B?TjlIbGEwWENvMCsxSDNLbzZlRyszM2FWMnY5cThqc1hSL2JndmprM1pxOUdP?=
 =?utf-8?B?TTBsZHRRQTRyWnZBdWZpYXV0MWMwZ0g1cHREQ3dlcWEySnVURkViZ2E1azlz?=
 =?utf-8?B?eXJiWEJEUFBZQXBqTDdGc2RoMWJIdE16NWpLTHJVNUphblZHTXgwU1p2bUNq?=
 =?utf-8?B?eGtUZlNzZ0p6RWV5eUV2TkRuZnlQTHl5Mlp0ejdFdWNwK3pWTWJGWmJ6eVdJ?=
 =?utf-8?B?NHBIZGU0QlVvbHh4S0VMQUFPLzdWZTlxRHFmKzBKckJyUmwvVldJajVVLzU3?=
 =?utf-8?B?N2VZampsSnRncnk3UXV1RldPdVQyZzFzVk1mdm9BUGpXK3JsMUpVaFAxODdi?=
 =?utf-8?B?OFFJalRmMWcwNnhEV01xRGRnRlNSeW1Uc0hMTThBNVVxZmZUQmhjbDFIZlRx?=
 =?utf-8?B?S3NYNE4zWnYva3lxYzdJSytlMTJ4Z25xMEtqN2VsendldnJMOGxnQ3V6TVVh?=
 =?utf-8?B?OXA0Tk9Zc0xJc2NrZUVZdDNFNHd2NUFqc1VObHplNTAxUFBlRkNYenB6dmd4?=
 =?utf-8?B?UTl0Q3JaVzlmQ2ZKNVYyOE9OVDgwM2R6TTNrNThWN1BZNkdlZTVVL0VjUnl2?=
 =?utf-8?B?Uys3UlJSdFB4aEJzMTBEUEdBaWJiMERpcmN2Smk2ZEFyQlR2MGN1d3U4UVE1?=
 =?utf-8?B?SExqZElHSFIzemFtZ3p3VmpLc01RTFhqOEo1QkR3dmd3Wk9NVWdHNHYzcnZw?=
 =?utf-8?B?RXAzN2RQT1F1ZlNHemhLQWYxek9rWkszZlFJRmcvK1gvclp3ZWFHbG9tYmdZ?=
 =?utf-8?B?WUtMckdCY0VCL2xMeldnUG9wWktXVFI3ZVNKVHFMaEtKV04wT2xyWjB4ak5n?=
 =?utf-8?B?dlhnZjUwckszTzJlTWhRVTZxM29uUDh1ZEFOeGJvRm9FR3c2VHZNNEpjeFdE?=
 =?utf-8?Q?ZJVS3XdwVIIYNgteKt0Rq6uAIB78GSNkoxlUQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SWR3Z2lSNGtiZG1YdEFMOTU4cWpVbzdQdUN6WHJNSU5VaDcvL0tGK1BEeVZl?=
 =?utf-8?B?MUFqUUdZYzU2emtsQ3pzUUFBTUV5ZmJhUEZYRndZUFpEMFFiMXNZbFRGTktm?=
 =?utf-8?B?TEQ1b3BLZk4vNHc1WjlQcUtmNVFVZGQ0THFCTWx4cUE1aEVsQXpjTWI2VlZM?=
 =?utf-8?B?eUZqSHBtdUVNV3Z3aVNUSExtV2hPN2NMc2pSeU9aNWVjRkdTeXVWMlhaVnJC?=
 =?utf-8?B?ZlpYTEtMdmN5M3ZZRkZwRThOZ2hJQ21pMENVaGkzWENBYnpoS0E2enY5Q3cy?=
 =?utf-8?B?TmZucGRMNVR4aW5Kc2w4b2J2VC9LQlcrd0NYRUdZYjRYcEpXY0VmYThZMzBP?=
 =?utf-8?B?T1hyVjM1ajBEOEFjbWt6cGo4VjV4VDYvdW82ekhFYU5vbk5wUytlQzNodUVI?=
 =?utf-8?B?bWxRUDNrSzRDL3RIcEMwcE1Kak5iUzc4aHFSZTNDNGZSNHlycndacG9pdy9M?=
 =?utf-8?B?YUF6a2U0RWlVYUNVU0dsTFFYTS95RHJnSDNZMUg3MEUvdXRSZ3JqWU9qYWpD?=
 =?utf-8?B?R3Qxb3U0cDc2NlVHSU9FTEJ1VU5VaEprY1p4YjVSbmIyNmNOeC9sK3lIem1O?=
 =?utf-8?B?RE9yMVVJcVVJalhiZTBWYm95N2pNS2RNTldvS2V3bVhUdzFCa2I0aWdTY2J5?=
 =?utf-8?B?T09MSWFTWVhwUVV4a0R0cFJIYW9SdmpUZTNVKzRRQjJwdllBNjRVTkR1MDFY?=
 =?utf-8?B?U01HNGFxdnJGSG14STNjZGtzeFZua3YrNWJuN3R6Sk1NcG1abWVVYXZEZ2ht?=
 =?utf-8?B?WnpSaG03bTBzaGpIb2x0VlZGUGZWcUdKWnVvOFRxUm5tVnJZYUoyMkxWMTFh?=
 =?utf-8?B?SUxCVS9iV1FrK0JIMzRiVUZUNlorQ3RGWThwUnNlMW8yRUJxUVVZeU1nUjJt?=
 =?utf-8?B?T0wyeWI3R1FPR3dyaWh3MWU4ay9wc0tKcllOTlpGc3ZzcXJVV1pheUpheHZn?=
 =?utf-8?B?alhoOU1NVXprbm1naWFrN2U0dGxCbmgwTDZab0xLQWNyUzIva2kvWFdCR3pO?=
 =?utf-8?B?WFBUUXkvbENKcXpzTUtXeUtpd2M1cEJDRWV5dzJsYVlac3hyeEVNbU9zR0Vp?=
 =?utf-8?B?TVM5ZVJXTkh5Qjh6dm5ZVmRvdnhTZjQwTGtGSkF3WU9JL0F4R2tnMm42Q0VY?=
 =?utf-8?B?aTZFU2FRYS9HMi9QWnZrTUQrYmlPVThpbkNjRFVURXd1UERYbWF3UFprbk1H?=
 =?utf-8?B?NVNmc00yUVByWUVqOHU3S0cyUm55aEJwbEJrR25FOGNpUHdha24wL0l1SEFl?=
 =?utf-8?B?R3B1ZStjYlpRWjd0N1hGVlhnaTg3ZUU1dEhYeGw1cE1XdDRFNTNuMHZZOUY0?=
 =?utf-8?B?c01RVWxDa2tZN2FSaVA3VmlEUTJnNDBhM0oxNURBT2p6bFJZOUV3akRzdHBj?=
 =?utf-8?B?TWNrL05iQytaTS9pMEU4MUdqZXZiRlBJT2NST25SWkhrN1FkV1FrTnZ1cDFu?=
 =?utf-8?B?Q21qU1M4OTlXVEVCUEZpMFl6Y3hkQjdOc3Nsa3lYdnZzSDFyNWNCdGtJTDJv?=
 =?utf-8?B?MStyMUZOdXRpcThTaHQ0dWpQaGNvNnF0TTJneFdEdjA0Qng4cFFmUkVzTCtP?=
 =?utf-8?B?bm10QmFPVkFPQXFZK0dKZmg5ODZQRGxMem1tUitFV2NNNU9PVHMwSms2MHcv?=
 =?utf-8?B?Z1FKOFN6Sll0WVVGVWpJOWNCaDZTNk5iUnZqcnF5d2JUWStkUG81V3dIRVg3?=
 =?utf-8?B?dEM2YjM0YTdCa0kzK3VSWWZiS1JSUW81endERHZZc1hDSm9LM2pzajJTWTFv?=
 =?utf-8?B?UXN3ZUYxdWNFdndUeEo0UXRQcm1aU3ZGOGpnYUU5Z2xtZU9reWh5UEd1UDhW?=
 =?utf-8?B?dVVVdjkxY3JCWWdSN0R1WlJqNXF6TnBjK2ZWVlBueW1xZUNoN041TWkyQWFn?=
 =?utf-8?B?RnhNYmxGRW11RVRjVDVVSkFYa2RJTUhtSCtJVzk0djJmU2xFQmdqN29mdmYx?=
 =?utf-8?B?amJRSzE5TUNRNFJYNjdLM3hTeG1XWGVNM1RScDhXUnpZdG5ERVM5NHR3UGVH?=
 =?utf-8?B?Z2prNUUrTHF5MWE3UldsT2gxcUhhZHZnRlM3M2pCdnFDMURJWWpCelptbkRB?=
 =?utf-8?B?WGl0ZjI4N3VScVFvZFhVS3NXN1BPUXJzREZ0dytaVC8vcmMvNDlvbytIYUFK?=
 =?utf-8?B?MEM1RTUvUmNQTGlJajY1M2p2VzFwY1BSN3M3VG40R3ZZOW5ndWZhUHFTRFFi?=
 =?utf-8?Q?hHbPMts68Zf6bWu8iY/yPpc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd04771d-fff1-4103-ddef-08dc95d1ea65
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 11:19:59.2913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2vC1+s8NYrd51pqCdF+fvtgOVpYmGMe4oo0mlmnGDzwD458Mj/7++dTB7ZESYKNnuY5ffk88oa9sugGAMhantnI5HozLaaM3YayGq/iQeIEA3/FC4Uc6THGhHS9rx+tN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10952
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 11:20:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16323

SGkgSmFuLA0KDQpUaGUgbWFuZGF0b3J5IGNvbmZpZ3MgdGhhdCBhcmUgcmVxdWlyZWQgYXJlIHRo
ZSB3Znggc2VydmVyIChiYWNrZW5kKSBVUkwgYW5kIHRoZSBjbGllbnQtaWQuIEFzIHBlciB5b3Vy
IHN1Z2dlc3Rpb24sIGZvciB0aGUgYmFja2VuZCBVUkwsIHByb3ZpZGluZyBhIGtjb25maWcgdmFy
aWFibGUgc28gdGhhdCB1c2VycyBjb3VsZCBlbnRlciB0aGF0IHZhbHVlIGJlZm9yZSB0aGUgYnVp
bGQgc2VlbXMgYSBsaWtlIGdvb2QgYXBwcm9hY2guDQoNCkhvd2V2ZXIsIEN1cnJlbnRseSBJIGFt
IG5vdCBjbGVhciBhYm91dCBzZXR0aW5nIHRoZSBjbGllbnQtaWQuIFRoZSBjbGllbnQtaWQgaXMg
cmVxdWlyZWQgYnkgd2Z4IHdoaWxlIGNyZWF0aW5nIHRoZSBqb2JzIGZvciB0aGUgc3BlY2lmaWMg
Y2xpZW50cyBhbmQgYWxzbyB0byBtb25pdG9yIHRoZSBzdGF0dXMgb2YgZWFjaCBjbGllbnQgZGV2
aWNlIChsaWtlIHVwZGF0ZSBzdGF0dXMgZXRjLikNCg0KU2V0dGluZyBhIGNsaWVudC1pZCBhbHNv
IHZpYSBhIGtjb25maWcgdmFyaWFibGUgd291bGQgbWVhbiBiZSB0byBidWlsZCBhIG5ldyBpbWFn
ZSBmb3IgZXZlcnkgbmV3IGNsaWVudC1pZCB3aGljaCBkb2Vzbid0IHNlZW0gbGlrZSBhIHJlYXNv
bmFibGUgc29sdXRpb24gZm9yIHByb2R1Y3Rpb24uIEkgYW0gbm90IHZlcnkgZmFtaWxpYXIgd2l0
aCBob3cgc3VjaCBkZXZpY2UgcmVnaXN0cmF0aW9uIC8gaWRlbnRpZmljYXRpb24gcmVxdWlyZW1l
bnRzIGFyZSBoYW5kbGVkIGluIGEgcHJvZHVjdGlvbiBlbnZpcm9ubWVudC4gRG8geW91IGhhdmUg
YW55IHBvaW50ZXJzIGluIHRoaXMgcmVnYXJkPw0KDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpBZGl0
aHlhIEJhbGFrdW1hcg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBP
biBCZWhhbGYgT2YgSmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQpTZW50OiBU
aHVyc2RheSwgSnVuZSAyMCwgMjAyNCA1OjAxIFBNDQpUbzogYmFsYWt1bWFyIGFkaXRoeWEo77y0
77yz77yp77ywIFRFVVIpIDxBZGl0aHlhLkJhbGFrdW1hckB0b3NoaWJhLXRzaXAuY29tPjsgY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBkaW5lc2gga3VtYXIo77y077yz77yp77yw
IFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBrdW5p
amFkYXIgc2hpdmFuYW5kKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPFNoaXZhbmFu
ZC5LdW5pamFkYXJAdG9zaGliYS10c2lwLmNvbT47IGFzaHJpdGggc2FpKO+8tO+8s++8qe+8sCkg
PFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWS
jOWujyDvvKTvvK3vvKUg4peL77yk77yp77yn4pah77yt77yw77yz4peL77yt77yw77yUKSA8a2F6
dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD47IENocmlzdGlhbiBTdG9ybSA8Y2hyaXN0aWFu
LnN0b3JtQHNpZW1lbnMuY29tPg0KU3ViamVjdDogUmU6IFtjaXAtZGV2XSBSZWdhcmRpbmcgc3Vw
cG9ydCBmb3IgV0ZYIGJhY2tlbmQgZm9yIHNvZnR3YXJlIHVwZGF0ZXMgaW4gQ0lQIEltYWdlcw0K
DQpPbiAyMC4wNi4yNCAwNzo1NiwgQWRpdGh5YS5CYWxha3VtYXJAdG9zaGliYS10c2lwLmNvbSB3
cm90ZToNCj4gSGkgQWxsLA0KPiANCj4gVGhpcyBpcyByZWdhcmRpbmcgc3VwcG9ydCBmb3IgV0ZY
IGJhY2tlbmQgZm9yIHNvZnR3YXJlIHVwZGF0ZXMgaW4gQ0lQIA0KPiBJbWFnZXMuIEkgYW0gd3Jp
dGluZyB0byB1bmRlcnN0YW5kIHRoZSBvcGluaW9ucyBvZiB0aGUgY29tbXVuaXR5IG9uIA0KPiBo
b3cgdG8gZ28gYWJvdXQgd2l0aCB0aGUgaW50ZWdyYXRpb24gb2YgV0ZYIHN1cHBvcnQuDQo+IA0K
PiBBcyBJIHVuZGVyc3RhbmQgdGhlcmUgYXJlIDIgcGFydHMgdG8gdGhlIFdGWCBpbnRlZ3JhdGlv
bjoNCj4gMS4gSG9zdGluZyB0aGUgV0ZYIHNlcnZlci4NCj4gMi4gU3VyaWNhdHRhIGNvbmZpZ3Vy
YXRpb24gaW4gdGhlIENJUCBJbWFnZXMgdmlhIHRoZSBzd3VwZGF0ZS5jZmcgZm9yIA0KPiBjb21t
dW5pY2F0aW9uIHdpdGggV0ZYIHNlcnZlci4NCj4gDQo+IEFzIGZyb20gdGhlIGRldmljZSBzaWRl
LCBjb21tdW5pY2F0aW9uIHdpdGggdGhlIFdGWCBzZXJ2ZXIgaXMgYWxyZWFkeSANCj4gc3VwcG9y
dGVkIGJ5IFNXVXBkYXRlIHRocm91Z2ggdGhlIHNlcnZlcl93ZngubHVhIG1vZHVsZS4gU2VlIFsx
XS4NCj4gSG93ZXZlciB0aGUgbmVjZXNzYXJ5IHN1cmljYXR0YSBjb25maWdzIGluIHRoZSBzd3Vw
ZGF0ZS5jZmcgZmlsZSBhcmUgDQo+IHJlcXVpcmVkIHRvIGJlIHNldCB3aGljaCBpcyBjdXJyZW50
bHkgbWlzc2luZyBmcm9tIGltYWdlIHJlY2lwZXMuDQo+IA0KPiBCYXNlZCBvbiBDSVAgQ29yZSB3
b3JrIGdyb3VwIG1lZXRpbmdzLCBJIHVuZGVyc3RhbmQgdGhhdCB0aGVyZSBpcyANCj4gYWxyZWFk
eSBhIHBsYW4gdG8gaG9zdCBhIFdGWCBzZXJ2ZXIgZm9yIENJUCByZWxhdGVkIHB1cnBvc2VzLiBX
aGlsZSANCj4gdGhhdCBpcyBzdGlsbCBpbiB0aGUgd29ya3MsIHdvdWxkIGl0IGJlIGFscmlnaHQg
dG8gdXBkYXRlIHJlY2lwZXMgdG8gDQo+IGluY2x1ZGUgdGhlIG5lY2Vzc2FyeSBjb25maWdzIG5l
ZWRlZCBmb3IgV0ZYIHN1cHBvcnQgb3Igd2FpdCBmb3IgdGhlIA0KPiBzZXJ2ZXIgc2lkZSB0byBi
ZSBjb21wbGV0ZWQ/DQo+IA0KPiBVbnRpbCB0aGUgcGxhbm5lZCBXRlggc2VydmVyIHNldHVwIGlz
IGNvbXBsZXRlZCwgaG93IGFib3V0IGluY2x1ZGluZyANCj4gZGV0YWlscyBvZiBzZXR0aW5nIHVw
IGEgV0ZYIHNlcnZlciBhbmQgb3RoZXIgZGV0YWlscyBmb3IgbWluaW1hbCANCj4gdmVyaWZpY2F0
aW9uIGluIGEgUkVBRE1FIGZpbGU/DQo+IA0KPiBXb3VsZCBsaWtlIHRvIHVuZGVyc3RhbmQgdGhl
IG9waW5pb25zIG9mIHRoZSBtYWludGFpbmVyIGFuZCB0aGUgcmVzdCANCj4gb2YgdGhlIGNvbW11
bml0eSBvbiBzdWNoIGFuIGFwcHJvYWNoIGFuZCBhbHNvIG90aGVyIGlkZWFzIG9uIGhvdyB0byBn
byANCj4gYWJvdXQgd2l0aCB0aGlzIGludGVncmF0aW9uPw0KPiANCg0KV2hhdCBhbGwgbmVlZHMg
dG8gZ28gaW50byB0aGF0IGNvbmZpZyBmaWxlPyBKdXN0IHRoZSBiYWNrZW5kIGFkZHJlc3Mgb3Ig
bW9yZT8gV2UgY291bGQgbWFrZSB0aGF0IGEga2NvbmZpZyB2YXJpYWJsZSBzbyB0aGF0IHVzZXJz
IGNvdWxkIGVudGVyIHRoYXQgdmFsdWUgYmVmb3JlIGJ1aWxkaW5nIGFuIGltYWdlIChhbmQgbGF0
ZXIgb24gZGVmYXVsdCB0aGUgYWRkcmVzcyB0byB3ZnguY2lwLXByb2plY3Qub3JnIG9yIHNvKS4N
Cg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVy
DQoNCg==


