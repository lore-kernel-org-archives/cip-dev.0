Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7840FCCD18E
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 08:53:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.11173.1760518415012326783
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Oct 2025 01:53:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 59F8rWlE751438; Wed, 15 Oct 2025 17:53:33 +0900
X-Iguazu-Qid: 2rWhlGorB3fxkuCVet
X-Iguazu-QSIG: v=2; s=0; t=1760518412; q=2rWhlGorB3fxkuCVet; m=D2DCRLV+rMlZ1oqCKN1NlaLK2NSKN1arpaTfBhp6sHU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cmlHJ1S5kz1xnl; Wed, 15 Oct 2025 17:53:31 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnDFqwKi95NRmKIIpZErlae2z983UYpEyjavuRSXCXbjNgwONw7TSzoAATJePqPs3o2eDoiwL4A6WMTDCQ7ov5d+AJ9CwupcWE/3vpGFoxFjdY2qHvUgbHfmVf1pC0ECzCV5yZSy1outFWsTbLj4sT5so8P4iIjm8s+dlAalKuOdkecdxXHJRF1rXL4U2liceyUuCRexY874cjF8IyqzFx+zqo96xZsiNNYbziZEp5g4kWkmADOQ2Tl2wZvLrptc5GexWhKFMswPvPJBSTRxNwR5l12vQQvqzwqOJivUk0tbfEeuZOG1O3y49mqn6rEbMjvGLNxzpvfgY1Vut0oFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuSXAfwazPKTjglw7NbM082/OFVzIQUGNYiZfdi83z4=;
 b=lV3uWo/M69kz2ZiSWwpX4jLBbpolYHXVWDMGCIc+ELYTo0Cn1UNx+xwIfr1+AHhv5ukYdyi8Y29T5E8+6/R+cRhDJWe3dEILI1ndV910cX0cn1+gtuU9fZIqWsKc22Uyx6Rm/E6rf3bZTQ5AYi1wO1LBiJlglZN9+V/yby9Lu8hrCey/vJbeIOZYJryDgWU3QuPo8DZuSz80G/mY/OlsfXPXS0XQQ2Hg/B4pIJRlrq7hEbB8/21Y2Oh6Thx/D+hpDup8c8kNhlyXkcM6QDGD6STyzFzSfZVZUyWM5qnOMCyEgU2ye1UfIPP2VD24WoooKFKJFt4b7F9ngXS/zUoz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <Shivanand.Kunijadar@toshiba-tsip.com>, <quirin.gylstorff@siemens.com>,
        <cip-dev@lists.cip-project.org>, <Chris.Paterson2@renesas.com>,
        <dinesh.kumar@toshiba-tsip.com>, <nobuhiro.iwamatsu.x90@mail.toshiba>,
        <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
Thread-Topic: [cip-dev] isar-cip-core: on-device tests failing
Thread-Index: 
 AQHcLVNE5p83CsDQTkSEPTvVfRFnpLSjqdSAgAAYrQCAAAOaAIAAQMiAgAXoUgCAACDWgIAAJuKAgBWrgoCAACL+AIABj1UAgAAqlwCAAAoNAIABEBmAgAArcGQ=
Date: Wed, 15 Oct 2025 08:53:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB96696580C7FDEB7E0CDC3782C4E8A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
 <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
 <232ddcae-a297-4e7d-9898-f34edd3671f1@siemens.com>
 <TYWPR01MB110639A5228DE9FB8CAC93E4EC7EBA@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <0f2a5909-4746-452a-8f39-187eaa9e3cd1@siemens.com>
 <6fc52da1-ce17-412a-85b0-8e36187ed56e@siemens.com>
 <8bf58a7b-cea2-480f-bec6-bcba41d450dd@siemens.com>
In-Reply-To: <8bf58a7b-cea2-480f-bec6-bcba41d450dd@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS3PR01MB9620:EE_
x-ms-office365-filtering-correlation-id: d0eb2d3b-ec52-4630-f390-08de0bc84ea1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|8096899003|13003099007|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bHBTWE1Xak0xUGhSQmV5VXdOYlN6YlVMakZzZ2ZRcjlNR1cxRVh1c1hi?=
 =?iso-2022-jp?B?SGlsdXAxR1h4NjR2U0FwYXZ5WkV0WEZ5S3QrUEhVeHROKzZ6R3MweVNi?=
 =?iso-2022-jp?B?VXBvcWxkMTZTTWlLeld3SlN2Z0UzUG9ubXdYcjVqZ3pvSnVCNkovSEVX?=
 =?iso-2022-jp?B?Z0lpeDZxMGNPRFVHZVpBaFVOY3ZicHc3NU1SZUtKOUFuQmtrZXljNTly?=
 =?iso-2022-jp?B?K2hCazdvbjZzekxOek9OcWtQUkZnMHZTUTltcGx5Sm13VEd6ZDRsOU4v?=
 =?iso-2022-jp?B?YkY1eVdiREwzcG0ySG9KMFBlaEZQN2pmc09HWnNJVDdIbGc5eFNDKy9t?=
 =?iso-2022-jp?B?Z0ZxeWZnWTQ2cUtoWWQ2TnlmRmdDNCtRTk84V0FzYnU1ellFY0ozZkw3?=
 =?iso-2022-jp?B?c0hzUjJFbEFXR2g2c3dyTEJxYnhsUHh0bUoxN2tqQ1dBUWgxNlpGM05D?=
 =?iso-2022-jp?B?WlEvbXRWVVhJQXhvbWx4TVk2OGkwbFdhaHByR3dxWmtkM1ZQdGxUMVZl?=
 =?iso-2022-jp?B?UTFnam10cy8yTCtYOTZSN1NubmtRUGRRRmZSMnV3Zk9nTHkxWC93T1Q4?=
 =?iso-2022-jp?B?L0dRWm1kMFBlcFdxZzRKQTBieWV6aENGdm5ranZrZEdlRlM4cVh2K0V5?=
 =?iso-2022-jp?B?VnNpWFdEQlZQaHpJTHl1VVg0U0FjVTk1SW9LRjBBaDRlNTZXcEVaRmtM?=
 =?iso-2022-jp?B?K0hNYUx2RVFqUlgyMjRhbzcwMFVLLzZFT2NoL2hxVE8vYU9tSTFlbmVo?=
 =?iso-2022-jp?B?aHM3SUp2dWVtRUs0eVlhWFU5QzJOWUFSd01Wc3lud2dEY0htWkJabS93?=
 =?iso-2022-jp?B?RWdmVGMrYUVqTTdYRm9rd2tsbyswYlBKYTVmMElDUGJoN3VJZjZmYTBt?=
 =?iso-2022-jp?B?eFlicUVZV1VBbW9yVjM2VUpOTlc0WkNXVm04c3pHWjlsb012amdibjNi?=
 =?iso-2022-jp?B?anZLUDN1NEZPY3V0YnhNRHd6RE1EeHBRYllRMDkyVWVmbFIzTXE5TWRN?=
 =?iso-2022-jp?B?M0R3b2xXcnF4c1BjMS8zOUVDNmlwUExvd0phS3RnWFZ5cGpnNlV2RzF1?=
 =?iso-2022-jp?B?RE9BR3VFVmswNCtSWldINml5V2xod01YcG1uR1YweWNKYmw5Z0VCZ3dM?=
 =?iso-2022-jp?B?VGRwTEJiMHZGVW5kakdkVEpkSDczVW5jRElPelc0SEozZDVVSGJHUzZ2?=
 =?iso-2022-jp?B?bWZHczMrRm1xTVpCa2N1aUVUM29YcUErNk45bjc4SDdwRnEvblNKM0Np?=
 =?iso-2022-jp?B?WlYxOW1aaE9HWVp3c1ZBSFFvRVJKWnR2TWgyM09IZ2x5VkxiYW00UkNq?=
 =?iso-2022-jp?B?dDhlaVZKTlZ4K1U2SnhYQ2hVVS9jWldMZ05mT09raFk0bWwwc3Uzcldj?=
 =?iso-2022-jp?B?Tkt5Y0xyTk9JNEVjQmNxeWpCTEQyc2cwWFI3cXd5aDF2U2p0SUFVQUk2?=
 =?iso-2022-jp?B?MHdzaFUrVmh6YXg2dDV6cmh2M21jZ1VndzVEU1phc0tQaFkrQVVYdFU0?=
 =?iso-2022-jp?B?NlhXR2lKSlVqU2xjWVJ3TGhXOWgvdGo1NVRGdnY1RGduRmExcVFXbks5?=
 =?iso-2022-jp?B?ZGFBOTUvb1BqZStVNjNaOGRrRUxNVmwxZ25MVG1pSDFlRGF4Q1VtOVBV?=
 =?iso-2022-jp?B?NTNJYlp0bnFnc3c4aVd5MGdEQUZIekxqQ3BYVERYdlYzUUFSK1o2UW5h?=
 =?iso-2022-jp?B?ckJYcC9HNmFIUUJMTmlVT05tYnl3VUI3dlFQQ2pCejZDVHlsMGxtTXBQ?=
 =?iso-2022-jp?B?Vm9vL214cE0xK1J2YnF2WWg0NTRWTjNQcVVibDFyY0RDdEpRejJEaWlv?=
 =?iso-2022-jp?B?RkEyOFVVZXp4RmxnUzZrbUtaVVFFZGMzK2J2elRiaUFtcWkrTy9hU0M2?=
 =?iso-2022-jp?B?SmRvR3RwamxNNzNydEZsZmR0U2RBeGJocDN5RGZxNjNXaEdvZUxyekVT?=
 =?iso-2022-jp?B?ZVpsUHFEY3AxWk14UkRzVVFrdGhMOHQwRUhtMUwydjhodllXQ0todGdP?=
 =?iso-2022-jp?B?NEZRd0pzREdNN3hmdkg5UWZhV0hGRERWd3lhWVFWTGtZWWRnQVRid1FN?=
 =?iso-2022-jp?B?UWJSMmlnNW96Qm5vMDBZQlBvY3M2VnRxQUJnaWNFV2lEdXo4NVJzVHJP?=
 =?iso-2022-jp?B?MG94VVN5RjNURDAzNE9hTDVZdnU0cjdZMy92czZKS01kSjZKemcrQTFz?=
 =?iso-2022-jp?B?V1ByUGVtWEZQVXJUWDdNVEtrbU4yNjUvWjZVNHd4VGxzVklJdEpIVGF2?=
 =?iso-2022-jp?B?V2VuWlo1OHZUS0FyOGRzbUo1QkhsM0x2UT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(13003099007)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UWcyTHNyNDFZOXQxOUxzWDBGcExteGR3bXU0alozNHpObUtPdndqeTRN?=
 =?iso-2022-jp?B?U2NiMWFQUGVJTGpmRnVPWEQrNU9LbVliT25HNEhaYWVqS3VMY1VsenFh?=
 =?iso-2022-jp?B?ZW55MUxLcmxydlF4bXNkZzFNV2FMRmZBakRudzJnS2xxWEdzTHBuN1Uw?=
 =?iso-2022-jp?B?Z0t1OS9icHBTdExGYUV5bEtlalpta0srOGxnMDd3emJIMzliaGprTnlG?=
 =?iso-2022-jp?B?ajhOTFJzRHpXMUNXMzRiSlluUnc3U2lVempQZ0hwR3dYMmR0b2JSM09Y?=
 =?iso-2022-jp?B?WHF5YjgzYXphZU0wbWd6VWc4ZzNaZHdxNmVFL2cza2I1U1kya3NwSHhW?=
 =?iso-2022-jp?B?ajRpMHYvZW8yRDEyTXhiSkNheXFOSjZ6L2R5YzVFRkMrMUJuYjRhRXp4?=
 =?iso-2022-jp?B?UTROTlpDb2QxRVhqcWJPam5nNHRyaGN4M0JVdnVFMlVYTmpSZ3d6SDNZ?=
 =?iso-2022-jp?B?R0Z2UThBT2NGd3ZPRmpsUndEdWZhRTEvSTR0Y2xSNlBNTHR1Rm9iMWtP?=
 =?iso-2022-jp?B?WVJPdHc0dXBmUm9mUWdXZlduUjZXdnZOeXZLVFBFRXVsbzQyMS9iNmxx?=
 =?iso-2022-jp?B?OW5IUUR3MWFyZXYxVFJDeVRZeUpnSFBIVE5qcStmU0ZkQ08yTi9Cakky?=
 =?iso-2022-jp?B?d1ZZQVYybWZGOURJUThFK3RJOTZnQ2Z1eW1nKzVqOUtZa002NytNdTFQ?=
 =?iso-2022-jp?B?Rksrb0h2VlgxM0l0Vk9aZ3ZtdFZBZC93YTlDY0NmUWVqeDJZN1RlcVMy?=
 =?iso-2022-jp?B?eFZyeVVzM090dmRZSktHWkdleVduWTY5S3BVUFdmY2JqTUhIS2J6ZjVS?=
 =?iso-2022-jp?B?dEZSSkpTVkg4QWhnY1p0VnE2RU5HNEdLYjN2ekxGempzVWt1bGN6YW9t?=
 =?iso-2022-jp?B?QmJ0VkN3TzlWd0hENXp4RjdZcmI1eGYrOVNqZGhDMkdRd3VOYVFJbWVr?=
 =?iso-2022-jp?B?ZlF5VXM0Q0pmU1ZjOWppTTZPaVZWcVZreW9vSjlvdWNsME4rT1lxZ3hv?=
 =?iso-2022-jp?B?WlM2OE5yNTZ3WklpZ3ZVZnYyTWMxQkNuVC9ZOVJtWFZVTTUvMkhWbXdN?=
 =?iso-2022-jp?B?SWxoT09aZzgvQzVsbXhZRFhmMVNPNW51UUw3YjBadGZ4ZXNJd2hTSFV4?=
 =?iso-2022-jp?B?QUxvRXhLOTg4OWZnVTdOZWhzL3JYV0V4SFdyUkpQakJPNmlRbGJJYXA4?=
 =?iso-2022-jp?B?ak1jMmFmam5OUUNxamo5ZG1oY1hkUENQSndqQlFBTmpSdTAyY1UreW5I?=
 =?iso-2022-jp?B?R3g3aDN4QTlQV2RCN21ON3B5eVc4THhieVFTNWx2a2t3QlV4Qll1ZzIw?=
 =?iso-2022-jp?B?ODE2WGc4S0ZURnBjMC9aZTIyZGdRU1F4b05zSEdNNzRqNTZ6VmNCM2tu?=
 =?iso-2022-jp?B?K2ZwWlhhbkNic1pBRUZiU2xkTmI5cDh5UHZyRkR0MEM5T0VoMXJDRUdT?=
 =?iso-2022-jp?B?UU9rejVGaDNUeU03cEY0RWI3aDZXQUplSmRBeWxRQmp1YmExTGFoUGZP?=
 =?iso-2022-jp?B?cXA2OEJDcG12VkFnMlVtZkZKSVlkTWp5ZG1DWEhhcTc3Y05vckVEdlVl?=
 =?iso-2022-jp?B?K3grUVBUbUxYcmJERDBHMmNvWXFKdVIvZkl6bDByOVFFRzF5Z1JjYTdz?=
 =?iso-2022-jp?B?QnZMeldIZkJzNktFWFVtY2hJc1N3TUg4SEFXd25OUGdZYlg1U21ubXFz?=
 =?iso-2022-jp?B?OGh5a3NqQ2pMNElhZ3BaS3Evay9hRGNmUGkwME0wREMzM0xPVVk1N0oz?=
 =?iso-2022-jp?B?RDBVaWs1NWVERi9aTjJRdlR4UnFLeElhRXJmaDRCbmI1bjA3OTZyeklz?=
 =?iso-2022-jp?B?M0xQTFVSMThCS1lpMi9OaHByWXdlUndSL3Y1U2NSY2sxVDF3VkZyQzA1?=
 =?iso-2022-jp?B?ZFo5RzNtaVR5aXg4RmgxOGVTdlAzeG9zUnQ4ZkFRZTQzT2RhdUExZERD?=
 =?iso-2022-jp?B?TTkxWm1JaHdFSUh6eXV0NmpHZUJCUHVwank4ZVhETEFLd2pPZnZJVHJD?=
 =?iso-2022-jp?B?NE5jbUR2b2lMU2pmTkVBVFhrTENhdHhXZ2d6WTVCc2Q4cEJYZS95WENt?=
 =?iso-2022-jp?B?Z2UrVUpkdWJ1R1NFc2JUeVhUTVM5SWZNS0lCNWg2RWFtdG1EZ1duVUZ6?=
 =?iso-2022-jp?B?MkJKYjNHTmV3cHRxaWcycmNpbzJ1QVpvL0kzOFRTbEtYY01TdXZSUHBZ?=
 =?iso-2022-jp?B?SkY1WmxEbE5kRkwweGZYUkt2M3AxKy9aZFgzL0pCYjVnajZzU1kxN2Na?=
 =?iso-2022-jp?B?bGNYUDNjZkI5bWxJNXNqU200endhV2RqUmJpUmRKcjd3eHlYa0t5a1Nu?=
 =?iso-2022-jp?B?RVBRVnNYY3NqWVlNYjkwVWVTQkxUWkRsNmc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB96696580C7FDEB7E0CDC3782C4E8ATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0eb2d3b-ec52-4630-f390-08de0bc84ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 08:53:27.3343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YfEiFryUwHF12dIgqhZeqlRlse2oQBerSvM46QfB2vEDzbPPqTOk3kPkyeMS8olqQ/k37vm4afr6Ak6mf0gJiiZv8OlFdbg5SqWl5zdmOljmbw+/wvBLkR6+l049boh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9620
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Oct 2025 08:53:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20176

--_000_TYCPR01MB96696580C7FDEB7E0CDC3782C4E8ATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Sorry to jump in here.

>We may have a kernel configuration issue here - or a real CIP kernel
>regression. Going back a month to a passing test, we got this back then:

>"The time taken to execute TC_CR1.9_1 is 28 seconds" [3]

>[3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/113440681=
59#L1724

What you are referring to in [3] is a qemu-amd64-IEC job (not M-COM).
QEMU IEC test jobs have always been quicker and are even now.

>"The time taken to execute TC_CR1.9_1 is 28 seconds" [3]

As far as I recall, I don't remember the IEC tests run this quick on the LA=
VA M-COM. Apologies if I am mistaken.

Thanks and Regards,
Adithya Balakumar

--_000_TYCPR01MB96696580C7FDEB7E0CDC3782C4E8ATYCPR01MB9669jpnp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Jan,<br>
<br>
Sorry to jump in here.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&gt;We may have a kernel configuration issue here - or a real CIP kernel<br=
>
&gt;regression. Going back a month to a passing test, we got this back then=
:<br>
<br>
&gt;&quot;The time taken to execute TC_CR1.9_1 is 28 seconds&quot; [3]<br>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&gt;[3] <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWA47a50=
d78-2cfd-eb21-00fd-fa554af008ac" href=3D"https://gitlab.com/cip-project/cip=
-core/isar-cip-core/-/jobs/11344068159#L1724">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11344068159#L1=
724</a></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
What you are referring to in [3] is a qemu-amd64-IEC job (not M-COM).&nbsp;=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt;" class=3D"elementToProof">
<span style=3D"color: rgb(0, 0, 0);">QEMU IEC test jobs have always been qu=
icker and are even now.<br>
<br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt;" class=3D"elementToProof">
<span style=3D"color: rgb(0, 0, 0);">&gt;&quot;The time taken to execute TC=
_CR1.9_1 is 28 seconds&quot; [3]</span><span style=3D"color: rgb(0, 0, 0);"=
><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt;" class=3D"elementToProof">
<span style=3D"color: rgb(0, 0, 0);"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt;" class=3D"elementToProof">
<span style=3D"color: rgb(0, 0, 0);">As far as I recall, I don't remember t=
he IEC tests run this quick on the LAVA M-COM. Apologies if I am mistaken.<=
br>
<br>
Thanks and Regards,</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Adithya Balakumar<br>
</div>
</body>
</html>

--_000_TYCPR01MB96696580C7FDEB7E0CDC3782C4E8ATYCPR01MB9669jpnp_--


