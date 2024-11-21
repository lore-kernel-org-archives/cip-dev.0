Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D274D6ED32
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 13:38:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.10810.1732196308150335750
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Nov 2024 05:38:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4ALDcOBN3659526; Thu, 21 Nov 2024 22:38:25 +0900
X-Iguazu-Qid: 2rWh0CjeOmZ4Z7ZPbk
X-Iguazu-QSIG: v=2; s=0; t=1732196304; q=2rWh0CjeOmZ4Z7ZPbk; m=Cdirq1m7we5waNah8LBHy1JiE9OXzh7mnFdIAB/Y0BU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 4ALDcNJF2326572
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 22:38:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8nWdXBhXpEu/ICag4oV/2OmSFsmrmeosToZKGIAv62pSmu13Us3nHxGa4MtUeiRThfWzcFK3UCme86QJwKXJBxOKqaq3EGsjsvzxUoai0k9wbKQtYpekYRXI8OEBdvDITfRtsK+saNkoSwRxVkRSDLb84FxfQk7f3xFsWJuXCcnCppw3AbUn649m+ypqjGgkCtZ3ZFPMv7v8PD+qC31HyO7ImnkpqxP0Ryun3bbiocfZCzK6d2PDjjrw+2XUKgTocK+tAa0Rje35vbsTpaeGl6ajhFzp3M+nyolXDYMZPHtRfUiyYDDcIaBNFR2LXX/mHgf5SKTpLgbNq+M++jgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj+7goVQKtPxJw2w/DFvRh1cyoz9gDmqDgQumX0fJYY=;
 b=xE3LXwVoPESjYeWIjwlbjphtCI+Wrvd2CQAQNpoo1MuJ7DBfsfjSFzHybrC3HPR5PSwPUU1yDo/8RDFB3cltstA9nM3xY9A9KMSvlkcdYFYTMvuexmrFbsxc3pSb7qm92i3popbAM5hjfh80i2HjUmR0x2PaGDYWEIXXZyqj3HO1tw9qDYhUGSkuRNQVMDe+Dv1ISpVyJvDKCr4Xjm4HpIIT5J0dfEkwDNMuocBEu921dPlCyFZpWhL8sK9O7fTXWPs3R6j025pDyHbvIffjFg6fMlbFAI+89g/bjPSk4iaXcn3UZiG5CU4t6dAos/+EgoNIGZkH4dIQ385D/+P0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <dinesh.kumar@toshiba-tsip.com>,
        <cip-security@lists.cip-project.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x86 and
 generate results
Thread-Topic: [cip-dev] Manually run Kernel and IEC tests on M-COM x86 and
 generate results
Thread-Index: AQHbNLcv3vC8deZB0Ua07zkQ6b5nXrKzrb4QgASohfaACXHRWw==
Date: Thu, 21 Nov 2024 13:38:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103A8419829A8FDDCC767FDC2222@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB1240281691D569EB3FFF1BF46B7592@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <1808283AFE02050D.20097@lists.cip-project.org>
In-Reply-To: <1808283AFE02050D.20097@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB6405:EE_
x-ms-office365-filtering-correlation-id: 0766b353-d35e-4746-2b31-08dd0a31c311
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?ks_c_5601-1987?B?ZkQwZmI2SVNUNi92L1ZydzNtNzRVcUxnZEhDY1Z1TlB4aVVXenkr?=
 =?ks_c_5601-1987?B?WXFRZ3A2MThqbkxnUEgxbzNrdlJvY2JRUy91TFFnenIwUFpweVpw?=
 =?ks_c_5601-1987?B?WUY0aGJDVFNKem9TS2IvOFZHSjRJQmFncXc4Mmg3d3pTN2hJMEN2?=
 =?ks_c_5601-1987?B?R1B4SDlRaVdxWCtnN095bUFkV21YbkMvTXoxT2FpWW56YlN6N0hu?=
 =?ks_c_5601-1987?B?R3FNVUp6MHdQMzNwSkRjL2U3UXYxRGxNT3hESG9jWlBuelBzNVFC?=
 =?ks_c_5601-1987?B?M0hYNEQ3VFRnMTFNR2t0b0RMQnVDNUdtWXU1VXF0YmlFRERjWFB5?=
 =?ks_c_5601-1987?B?WEFpTmsrcjROdzV6WjNMd3BWZi9rMG9EU2x4Z2VOaWpWRnBTTmNx?=
 =?ks_c_5601-1987?B?Z2FJQmVIcGNNLytpUmV4WU52Z2h2OGdiSFZKWmZiRDA4OEdiR2t2?=
 =?ks_c_5601-1987?B?WExxUURORFFrMHVTQk5SbU5ERFNrZy92Rm9tdTIrT29aNTRteWdQ?=
 =?ks_c_5601-1987?B?WXVRb1p4UkNBWkN5UFdyK2trYTRwaS9SS2RLRkpUYnBqNk9qUzI3?=
 =?ks_c_5601-1987?B?eldhUTRRYWg0cytKV3E3dGJjQ1Y2L2xoajBvZUNWWGJLSSt2KzNV?=
 =?ks_c_5601-1987?B?OUxOQkJMTlhaZnQ1Y3h0T0xPUkd6cXc3NFd3KzdPaHFqUWVqZTRo?=
 =?ks_c_5601-1987?B?MmRWTnJNRU1yOVAwYnFxbzZuaXpiSFpKWWgvSGMxV0RGQzlCTXhR?=
 =?ks_c_5601-1987?B?czRIalpURVgwQXJqa0ZrTWJDNmFSRzh5UHBZSUkveUVJK2I1V2Q5?=
 =?ks_c_5601-1987?B?RE5mYjZCM1haaGNVUWxnL1BndVlmbVNGaENXU094KzMxdzVlUmFV?=
 =?ks_c_5601-1987?B?bDdibFFBMEhQYkt0elEwOWxhaU02ME92R3MrSTh2OVlyS3FJQmZh?=
 =?ks_c_5601-1987?B?NGpKQWhsTldPOTFQUmhtZEJGK0NEWXdQQ3JNako1YjRsaUtOWnBH?=
 =?ks_c_5601-1987?B?RkRYV21sR255SW9HTXBCV1ZZa2pYMStKbHhZMUJCQ1VaNmZhS1R3?=
 =?ks_c_5601-1987?B?TG13U3JFZldvZjd3L1pLMy85cGE3WmdvY2JiWGdkcDc3NmZ0NXM5?=
 =?ks_c_5601-1987?B?eXVRWmxMTWpPWStFSDNETUlVTFFsYjRHa0NkeklZRG1pNDd0Y3lU?=
 =?ks_c_5601-1987?B?WlpPRnlndnZ3a3A1alB4a3J2S2Zzc2p3c1cvTGJrd0p2UkhHeWU4?=
 =?ks_c_5601-1987?B?azZlYXFNaGJQb2lXQkZMaTN0Q1EzN3lqcE4zdXlnaUkrOTFnQVgv?=
 =?ks_c_5601-1987?B?S1NQMHEwV3hla2xlRys2NEIvbW9lOFJuNmNCVENJYzhGTGFoMGhZ?=
 =?ks_c_5601-1987?B?d2UyWk5wSGIwOW4rUGlhcENSdnhndFBYKzlQUEtua0ZwZ2VJa0R2?=
 =?ks_c_5601-1987?B?NmoyUDRQNzdRTlVJYWRQZVN1clpxcFd0R2pCS2FTZ2F1cWcwRFVS?=
 =?ks_c_5601-1987?B?bmtvTmhrSDNMcG5HOWR6VkV0ZHBDTUdqaXRheTgwanlWMmRrdlJC?=
 =?ks_c_5601-1987?B?c2pFM0xEUnZldTBUUVRlZklleE5Jc2JKVjBNMFRsL2x4YktxcEs4?=
 =?ks_c_5601-1987?B?TjZaZ0FXSS9iS2M1OWp3L0pTU0ExQ1ZsZnBjKzVJcFBtaUYrcU1n?=
 =?ks_c_5601-1987?B?L01rSWpyenJENjRWeDl4b0RTMGxMUkhVbXNCUWw5QUxpbGNOYXVL?=
 =?ks_c_5601-1987?B?NkZDYURFVXNrVVBNZGF6RDBPd3MxZStHOUxLQkZPdmxrdVlzZnBx?=
 =?ks_c_5601-1987?B?SGczTGFvNGVNRlVCSjFGbmRrTTdoSTlick9zdU5hR2VaNlNNL1VQ?=
 =?ks_c_5601-1987?B?cENRUGFEaG5uaVE4S0FieHZXdk5ZZGpMRUJIMlIzMFVaWUlvL002?=
 =?ks_c_5601-1987?B?ZUNWQzd2V0dIemRzTERZTkprM05FaHJkaTBrbHlYeDZJb0FGTDc3?=
 =?ks_c_5601-1987?B?d2gwWVVHVklNSHphUEM1Ykk4dkFkSlp1YUFSejA1R3cyT1I5S05u?=
 =?ks_c_5601-1987?B?Tlk2YTlFSUdMYUQrZUpqL1RWUjVMOGpMSXBSNXNuTTdYUjZMR0tW?=
 =?ks_c_5601-1987?B?UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?ks_c_5601-1987?B?RytFM1RpRVY4eVRxRUJLOE1pWmxuQW4rSTIrNFpjOHAwSkN6SVQx?=
 =?ks_c_5601-1987?B?L2FCZmM3UlBtaVBWZjZyU0lKc3pLUjhUSXJJT0NnS09kV2s2TFA2?=
 =?ks_c_5601-1987?B?K3p1c3IwVjFwQ1BNdmxpTk1TVnNwa25UT2hCQmVxVE9ZcDBkRXFt?=
 =?ks_c_5601-1987?B?Zm9DcENjYklMTEUvZEdTaXlscmc1Y1ZKRGFpNUZ4SjlwblJYbGhv?=
 =?ks_c_5601-1987?B?M3RmeExmeXpnV1ZuTU1EeGN0YVhudFdoZUFrYktmWklSdld2ZmY5?=
 =?ks_c_5601-1987?B?dFJlNHh0R2ZEWlBPK00wNG1nWk0zdzdjMjI0N0JGbkh6N1dkL0No?=
 =?ks_c_5601-1987?B?Q2NGWm5TQXR3RERuNWtwRnd6cklYcDJQZXpOdnhuVDZUeCttVlAr?=
 =?ks_c_5601-1987?B?SUJmVlZqRmdGY2NYalkrclZRTGdlRkFaNDZGV3FQRDNSd3FnelQ5?=
 =?ks_c_5601-1987?B?MGhFanN2cVRaRi9zRWQydFNhVEg1RkdndVl4TU5JYjc2cDdjZkNE?=
 =?ks_c_5601-1987?B?ZitBbW5uZ1piVm5tZWxPdTkxdk1veDRVVXNKdzJURVd3dFB5Y0wv?=
 =?ks_c_5601-1987?B?cUF6d0c0VkgzdlpVWWVUNHlJZVhHV2tOcCtJelNIcElCUGMrcHpK?=
 =?ks_c_5601-1987?B?Vzd4cGMzc2dDUjMyekhNSExENHIyWmJnNW1QbUNucEJzRWRoWXZv?=
 =?ks_c_5601-1987?B?RDVXaklJeDVWZkJ2Sy94blUybFZscDZTM2ttNWdmVXZCYlJ3L3c1?=
 =?ks_c_5601-1987?B?L01Bc2F5akQ1L0ZTRUhkdHEwYW5EY2VJd05wc0FiUkJkZXpQMzh2?=
 =?ks_c_5601-1987?B?WTVDUUVEbDNpOS9XQjltQW5DeDc1QWdDSVVPeUVpR3k3QWVrbWxR?=
 =?ks_c_5601-1987?B?YVZPU2pieWVNbiswWjNrbm01YUdHL1F6WWRkeE5uTk1iTENoN0lJ?=
 =?ks_c_5601-1987?B?REdESW5QV2h1aUZLWERQcXh0dy9lOEN5S0pXajFUTjJ0R2lzTG5N?=
 =?ks_c_5601-1987?B?WlQ0bnVVOTFSeG50a2Nnd3pxdkNKcHlrZW1tcFh5SjlVbjM4UXA0?=
 =?ks_c_5601-1987?B?b0FiVWZCWmg2WlBTeUF2Rk5RTXJvUEdRWXlvL3hFSmI1NEtpcjY2?=
 =?ks_c_5601-1987?B?L0MzQUJ5RjZhOWtVY1RnZWFzRytMVVpwMDNSQWRXcDVDdUVBSnFl?=
 =?ks_c_5601-1987?B?Rjc3M0FhZEtDekM0dlVJaStkN3pWQ3dkTUJ2MlJ2WUo2Ym9KMERn?=
 =?ks_c_5601-1987?B?dU4vYWtIL2pjUkp2YU9xdW9sNGQ3enRYY1hNTEN5RnVHbXRXV0h3?=
 =?ks_c_5601-1987?B?WGVSbUJONXVMMEdGYUlZdmNoRnU3SFF4Uk1nTVBQZTA4UFJOVGRB?=
 =?ks_c_5601-1987?B?KzJVcU9ubGhDZkF3R0cydzFzSThqS3ZDWTAzN1cxazJhN2NmODV6?=
 =?ks_c_5601-1987?B?RUluampNVVhjQTdXSHFWV2pmSGJEUnpIMWJEM0l0cW9pcXY2YVht?=
 =?ks_c_5601-1987?B?SC9PZnhVL3JFWWtKaHJ0eHZIZzJ3cXhGZVBCQTVRakw0NTM2UEFX?=
 =?ks_c_5601-1987?B?ZmdIemprM0JuMHIzRUJjMTh3NUg0RWp2akh3MElZTDNscDVkcVgz?=
 =?ks_c_5601-1987?B?OEdxKzZPRUJSRS9wVDFQNXo1aTRURWVkVlR5V1hlUkhQNkc5TnNi?=
 =?ks_c_5601-1987?B?RlJ1Z01iZW1mR05hdDMxNzNFMGFsamJqY3NpVXlnYVVONXVtUUFk?=
 =?ks_c_5601-1987?B?Mm9odnZ4NGg4T2k3S0NZbDNqd0NDSDRNdE9yUVdPcHV2RTh1dnZs?=
 =?ks_c_5601-1987?B?MEIvSHhZbUVGRzBRamVOTVNvWk5FWnpPRDA3Z1hQMEpobUw0ZVNO?=
 =?ks_c_5601-1987?B?YUtSc0VpK080dkFoZm9vSUFGUmMyRFAybWNNaFg4cVl2UnJtMzd1?=
 =?ks_c_5601-1987?B?U3NHbnZpT1JaOURlQnlEcksyWTRmMXkxU29wZ3F6WHBCSld4MEc2?=
 =?ks_c_5601-1987?B?cllXWWd2TG91OHVpVHlqdVVpWEhZakdkZ0RTaVlXQnIyQ1A2T2VD?=
 =?ks_c_5601-1987?B?ODhYb0x6V3pvVFhJZ3lsMnZrWGtiTE5UNmtJTWlFeHdoc1Q4ZXc2?=
 =?ks_c_5601-1987?B?eWxPc0hCcXhjRVlsbTJqVVZhTXVzL2hHd05NZ0F4eWVsMy8wck90?=
 =?ks_c_5601-1987?B?RmlZSS85UExiczVUSkc4OEtaUzRlWFhHc2cyZVlFNlZWOGlkZEV5?=
 =?ks_c_5601-1987?B?Z3lUc0kwUTZURitEbVVrR3ZqL1RLUnROSDRCTDQvODJ5VEJPbHkz?=
 =?ks_c_5601-1987?B?ZDBBa285MXVta25NeW9URzBzWUE1Sk56UDMyR3NBQVdjUFpUa25o?=
 =?ks_c_5601-1987?B?M0lNTUtGdU0rQjhLRldta1dlUUFXQkVMWXRNa1FZcmdNQWN1Wm1U?=
 =?ks_c_5601-1987?B?STJkZUZqZ0tiTHU1dVBocVQ2eWZHOTNMZ2Y2QURIMXEwWkN1bnh0?=
 =?ks_c_5601-1987?B?Z3FDZi8rY3MzRGdOREtqcVFXTUx4YUE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103A8419829A8FDDCC767FDC2222OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0766b353-d35e-4746-2b31-08dd0a31c311
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 13:38:19.8201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tkafco4MfKaD94gi7mACZMOqOZLli9pA6trkUWC5SAoRkFUAoAqfnIMsYONYje8w5fstNZ67een11X+8/6VpcaF/N+YoOLqyDvhTZaa6fHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6405
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Nov 2024 13:38:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17266

--_000_OS3PR01MB6103A8419829A8FDDCC767FDC2222OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

SGVsbG8gQ2hyaXMsDQoNCkhvcGUgeW91IGFyZSBkb2luZyBncmVhdC4NCg0KVGhpcyBpcyBqdXN0
IGFuIHVwZGF0ZSByZWdhcmRpbmcgbXkgcHJldmlvdXMgcXVlcnkgaW4gdGhpcyBtYWlsIHRocmVh
ZC4NCg0KSSB3YXMgYWJsZSB0byBydW4gTFRQIG9uIHNlY3VyaXR5IHRhcmdldCBpbiBteSBtYWNo
aW5lIGFmdGVyIGluY2x1ZGluZyBrYXMvb3B0L3Rlc3QueW1sIKGkIG1hc3RlciChpCBjaXAtcHJv
amVjdCAvIGNpcC1jb3JlIC8gaXNhci1jaXAtY29yZSChpCBHaXRMYWI8aHR0cHM6Ly9naXRsYWIu
Y29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9ibG9iL21hc3Rlci9rYXMv
b3B0L3Rlc3QueW1sP3JlZl90eXBlPWhlYWRzPiB3aGlsZSBidWlsZGluZyB0aGUgaW1hZ2UgYXMg
aXQgY29tZXMgYWxsIHRoZSBkZXBlbmRlbmNpZXMgcmVxdWlyZWQgdG8gcnVuIHRoZW0uDQoNCkZv
ciBMQVZBLCBJIHdpbGwgdHJ5IHRvIHVwbG9hZCBhIHJvb3RmcyB0YXJiYWxsIHRvIGNpcC1wcm9q
ZWN0J3MgUzMgc3RvcmFnZSB3aXRoIGJ1aWxkOng4Ni11ZWZpLWJhc2UgY29uZmlndXJhdGlvbiBh
bG9uZyB3aXRoIGV4dGVuc2lvbjogdGVzdC4gSSBob3BlIEkgY2FuIHJ1biBMVFAgdGVzdHMgb24g
TS1DT00geDg2IG9uIExBVkEgd2l0aCB0aGlzIG1ldGhvZC4gSSByYW4gU01DIHRlc3RzIG9uIE0t
Q09NIHg4NiB3aXRoIDYuMS4xMTItY2lwMzAga2VybmVsIC0+IGh0dHBzOi8vbGF2YS5jaXBsYXRm
b3JtLm9yZy9yZXN1bHRzLzEyMjI2MTYvMF9zcGVjdHJlLW1lbHRkb3duLWNoZWNrZXItdGVzdA0K
DQpUaGFua3MgYW5kIHJlZ2FyZHMuDQpTYWkgQXNocml0aA0KDQoNCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCkZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gb24gYmVoYWxmIG9mIHNhaS5zYXRodWpvZGFA
dG9zaGliYS10c2lwLmNvbSA8c2FpLnNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KU2VudDog
RnJpZGF5LCBOb3ZlbWJlciAxNSwgMjAyNCA3OjE0IFBNDQpUbzogQ2hyaXMuUGF0ZXJzb24yQHJl
bmVzYXMuY29tIDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+DQpDYzogaGF5YXNoaSBrYXp1
aGlybyjX+SD7+s7bIKPEo82jxSCh26PEo8mjx6Hgo82j0KPTodujzaPQo7QpIDxrYXp1aGlybzMu
aGF5YXNoaUB0b3NoaWJhLmNvLmpwPjsgZGluZXNoIGt1bWFyKKPUo9OjyaPQIFRNSUVDIE9ERyBQ
b3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtc2VjdXJpdHlAbGlz
dHMuY2lwLXByb2plY3Qub3JnIDxjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qub3JnPjsg
aXdhbWF0c3Ugbm9idWhpcm8o5Nvh5iDj4eXHIKHbo8SjyaPUo8Oh4KPEo8mj1KHbo8+j06PUKSA8
bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9q
ZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+DQpTdWJqZWN0OiBSZTogW2Np
cC1kZXZdIE1hbnVhbGx5IHJ1biBLZXJuZWwgYW5kIElFQyB0ZXN0cyBvbiBNLUNPTSB4ODYgYW5k
IGdlbmVyYXRlIHJlc3VsdHMNCg0KSGVsbG8gQ2hyaXMsDQoNCkhvcGUgeW91IGFyZSBkb2luZyB3
ZWxsLg0KDQpBZnRlciBnb2luZyB0aHJvdWdoIExhdmEgam9iIGRlZmluaXRpb25zIHdoZXJlIGx0
cCB0ZXN0cyBhcmUgcnVuIG9uIENJUCByZWZlcmVuY2UgaGFyZHdhcmUgb24gQ0lQIExBVkEsDQoN
Ckkgbm90aWNlZCB0aGF0IGx0cCB0ZXN0cyBhcmUgYmVpbmcgbW9zdGx5IG9uOg0KDQpyZW5lc2Fz
X3I4YTc3NDMtaXdnMjBkLXE3DQpyZW5lc2FzX3I4YTc3NGExLWhpaG9wZS1yemcybS1leA0KeDg2
X2NpcF9xZW11DQoNClVzaW5nIHJvb3RmcyB0YXJiYWxscyBzdWNoIGFzOg0KDQpodHRwczovL3Mz
LWV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tL2Rvd25sb2FkMi5jaXAtcHJvamVjdC5vcmcvY2lw
LXRlc3RpbmcvbGF2YS1oZWFsdGhjaGVja3MvcmZzL2NvcmUtaW1hZ2UtbWluaW1hbC1xZW11YXJt
NjQtbHRwLnRhci5iejINCmh0dHBzOi8vczMtZXUtY2VudHJhbC0xLmFtYXpvbmF3cy5jb20vZG93
bmxvYWQyLmNpcC1wcm9qZWN0Lm9yZy9jaXAtdGVzdGluZy9sYXZhLWhlYWx0aGNoZWNrcy9yZnMv
Y29yZS1pbWFnZS1taW5pbWFsLXFlbXV4ODYtNjQtbHRwLmV4dDQueHoNCg0KLi5hbG9uZyB3aXRo
IHJlc3BlY3RpdmUgZHRiIGZpbGVzLg0KDQpCdXQgY3VycmVudGx5IG0tY29tIGhlYWx0aCBjaGVj
a3MgYXJlIHVzaW5nIGh0dHBzOi8vczMtdXMtd2VzdC0yLmFtYXpvbmF3cy5jb20vZG93bmxvYWQu
Y2lwLXByb2plY3Qub3JnL2NpcHRlc3RpbmcvY2lwLWxhdmEvcmZzL3Jvb3Rmcy1zaW1hdGljLWlw
YzIyN2UudGFyLmd6IHJvb3Rmcy4NCg0KSSB0cmllZCB0byB1c2UgIFNLSVBfSU5TVEFMTDogImZh
bHNlIiBpbiB0aGUgdGVzdCBkZWZpbml0aW9uIGJlY2F1c2UgbHRwIHRlc3QgY2FzZXMgYXJlIG5v
dCBwcmVzZW50IGluIGV4cGVjdGVkIGZvbGRlcnMsIGV4OiAvb3B0L2x0cCBhbmQgZGVwZW5kZW5j
eSBwYWNrYWdlcyBhcyB3ZWxsIGV4cGVjdGluZyB0aGV5IHdpbGwgYmUgaW5zdGFsbGVkIGluIHRo
ZSBpbWFnZSBhZnRlciBib290LiBCdXQgdGhlIGpvYiBmYWlsZWQuIGh0dHBzOi8vbGF2YS5jaXBs
YXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzEyMjMxNDkjTDEzMzkNCg0KSSByZXF1ZXN0IHlvdSB0
byBoZWxwIG1lIGluIHByZXBhcmluZyBhIHNpbWF0aWMtaXBjMjI3ZSByb290ZnMgdGFyYmFsbCB3
aXRoIGx0cCB0ZXN0cyBhbmQgcmVxdWlyZWQgcGFja2FnZXMgYW5kIHB1c2hpbmcgY2lwLXByb2pl
Y3QgczMgc3RvcmFnZSBzbyB0aGF0IEkgY2FuIHJ1biBsdHAgdGVzdHMgb24gbS1jb20gZGV2aWNl
LiBQbGVhc2Ugc3VnZ2VzdCBpZiB5b3Uga25vdyBhbnkgYWx0ZXJuYXRlIHJvb3RmcyBjYW4gYmUg
dXNlZCB0byBib290IG9uIG0tY29tIGRldmljZS4NCg0KVGhhbmtzIGFuZCByZWdhcmRzLA0KU2Fp
IEFzaHJpdGgNCg0KaHR0cHM6Ly9zMy1ldS1jZW50cmFsLTEuYW1hem9uYXdzLmNvbS9kb3dubG9h
ZDIuY2lwLXByb2plY3Qub3JnL2NpcC10ZXN0aW5nL2xhdmEtaGVhbHRoY2hlY2tzL3Jmcy9jb3Jl
LWltYWdlLW1pbmltYWwtcWVtdWFybTY0LWx0cC50YXIuYnoyDQpodHRwczovL3MzLWV1LWNlbnRy
YWwtMS5hbWF6b25hd3MuY29tL2Rvd25sb2FkMi5jaXAtcHJvamVjdC5vcmcvY2lwLXRlc3Rpbmcv
bGF2YS1oZWFsdGhjaGVja3MvcmZzL2NvcmUtaW1hZ2UtbWluaW1hbC1xZW11eDg2LTY0LWx0cC5l
eHQ0Lnh6DQoNCg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmc+IG9uIGJlaGFsZiBvZiBDaHJpcyBQYXRlcnNvbiB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3Jn
IDxjaHJpcy5wYXRlcnNvbjI9cmVuZXNhcy5jb21AbGlzdHMuY2lwLXByb2plY3Qub3JnPg0KU2Vu
dDogVHVlc2RheSwgTm92ZW1iZXIgMTIsIDIwMjQgNzozOSBQTQ0KVG86IGNpcC1zZWN1cml0eUBs
aXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1zZWN1cml0eUBsaXN0cy5jaXAtcHJvamVjdC5vcmc+
OyBpd2FtYXRzdSBub2J1aGlybyjk2+HmIOPh5ccgodujxKPJo9Sjw6Hgo8SjyaPUodujz6PTo9Qp
IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCkNjOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+OyBoYXlhc2hpIGth
enVoaXJvKNf5IPv6ztsgo8SjzaPFIKHbo8SjyaPHoeCjzaPQo9Oh26PNo9CjtCkgPGthenVoaXJv
My5oYXlhc2hpQHRvc2hpYmEuY28uanA+OyBkaW5lc2gga3VtYXIoo9Sj06PJo9AgVE1JRUMgT0RH
IFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT4NClN1YmplY3Q6IFJlOiBb
Y2lwLWRldl0gTWFudWFsbHkgcnVuIEtlcm5lbCBhbmQgSUVDIHRlc3RzIG9uIE0tQ09NIHg4NiBh
bmQgZ2VuZXJhdGUgcmVzdWx0cw0KDQpIZWxsbyBTYWksDQoNCj4gRnJvbTogY2lwLXNlY3VyaXR5
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLXNlY3VyaXR5QGxpc3RzLmNpcC0NCj4gcHJvamVj
dC5vcmc+IE9uIEJlaGFsZiBPZiBzYWkgYXNocml0aCBzYXRodWpvZGEgdmlhIGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZw0KPiBTZW50OiAxMiBOb3ZlbWJlciAyMDI0IDA0OjE0DQo+DQo+IEhlbGxvIENo
cmlzLA0KPg0KPiBIb3BlIHlvdSBhcmUgZG9pbmcgd2VsbC4NCj4NCj4gUmVnYXJkaW5nIElFQyA2
MjQ0My00LTIgY2VydGlmaWNhdGlvbiwgdGhlIGNlcnRpZmljYXRpb24gYm9keSBoYXMgYXNrZWQN
Cj4gZm9yIEtlcm5lbCBhbmQgSUVDIHRlc3QgcmVzdWx0cyBvbiBNLUNPTSBkZXZpY2UuIEJhc2Vk
IG9uIG15IGN1cnJlbnQNCj4ga25vd2xkZWdlLCBJIGJlbGlldmUgdGhhdCB0aGUgdGVzdCBzdWl0
ZXMgbWVudGlvbmVkIGhlcmUNCj4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10
ZXN0aW5nL2xpbnV4LWNpcC1jaS8tDQo+IC9ibG9iL21hc3Rlci9zdWJtaXRfdGVzdHMuc2g/cmVm
X3R5cGU9aGVhZHMjTDU1IDxodHRwczovL2dpdGxhYi5jb20vY2lwLQ0KPiBwcm9qZWN0L2NpcC10
ZXN0aW5nL2xpbnV4LWNpcC1jaS8tDQo+IC9ibG9iL21hc3Rlci9zdWJtaXRfdGVzdHMuc2g/cmVm
X3R5cGU9aGVhZHMjTDU1PiAgc2hhbGwgcnVuIGZvciBldmVyeQ0KPiB1cGRhdGVkIGtlcm5lbCBp
bWFnZSBvbiBkaWZmZXJlbnQgQ0lQIHJlZmVyZW5jZSBoYXJkd2FyZSBpbiBMQVZBLg0KPg0KPiBT
aW5jZSBhdmFpbGFiaWxpdHkgb2YgTS1DT00gZGV2aWNlIG9uIENJUCBMQVZBIExhYiBzdGlsbCBu
ZWVkcyBzb21lIHRpbWUsDQo+IHdlIGFyZSBtYW51YWxseSBydW5uaW5nIGVhY2ggdGVzdCBzdWl0
ZSBpLmUgU01DLCBTbW9rZSwgTFRQIGV0Yy4gZnJvbQ0KPiBodHRwczovL2dpdGh1Yi5jb20va2Vy
bmVsY2kvdGVzdC1kZWZpbml0aW9ucw0KDQpBcyBKYW4gc2FpZCAtIHdlIG5vdyBoYXZlIG9uZSBp
biBDSVAncyBMQVZBLg0KSWYgeW91IGhhdmUgaXNzdWVzIHVzaW5nIGl0IHBsZWFzZSBsZXQgbWUg
a25vdy4NCg0KPg0KPiBUaGVyZSBhcmUgbm8gaXNzdWVzIHdpdGggcnVubmluZyBTTUMsIFNtb2tl
IHRlc3RzIGJ1dCB3aGlsZSBydW5uaW5nIExUUA0KPiB0ZXN0cyBpdCBpcyB0cnlpbmcgdG8gaW5z
dGFsbCBzb21lIGRlcGVuZGVuY3kgcGFja2FnZXMgdG8gdGhlIHJvb3QgZmlsZQ0KPiBzeXN0ZW0u
IEN1cnJlbnRseSBpdCBzaG93cyBpdCBpcyBhIG5ldHdvcmsgaXNzdWUgYnV0IGV2ZW4gaWYgaXQg
Z2V0cw0KPiByZXNvbHZlZCwgdGhlIHBhY2thZ2VzIGNhbm5vdCBiZSBpbnN0YWxsZWQgYmVjYXVz
ZSB0aGUgc2VjdXJpdHkgaW1hZ2UgaGFzDQo+IHJlYWQtb25seSByb290IGZpbGUgc3lzdGVtLg0K
DQpTbyB5b3UnZCBlaXRoZXIgaGF2ZSB0byB1c2UgYSB3cml0YWJsZSBmaWxlc3lzdGVtIG9yIHBy
ZS1pbnN0YWxsIGV2ZXJ5dGhpbmcgaW50byB0aGUgb3JpZ2luYWwgaW1hZ2UuDQoNCj4NCj4gQW5v
dGhlciBpZGVhIHdoaWNoIG5lZWRzIHRvIGJlIGRpc2N1c3NlZCBpcywgc2luY2UgS2VybmVsIHRl
c3RzIGJ5IG5hbWUNCj4gbWVhbnMgZm9jdXNpbmcgb24gdGVzdGluZyBvbmx5IHRoZSBLZXJuZWws
IHdlIGNhbiB0cnkgdG8gdXNlIGEgZGlmZmVyZW50DQo+IHJvb3QgZmlsZSBzeXN0ZW0gdG8gcnVu
IHRoZXNlIHRlc3RzLiBCdXQgdGhpcyBpcyBqdXN0IGFuIGlkZWEsIHRoaXMgbmVlZHMNCj4gdG8g
aW50ZXJuYWxseSBiZSBkaXNjdXNzZWQgd2l0aGluIFNXRyBhbmQgd2l0aCBDZXJ0aWZpY2F0aW9u
IGJvZHkuDQoNClRoZXJlJ3Mgbm8gaGFybSBpbiB1c2luZyBhIGRpZmZlcmVudCByb290ZnMsIG9y
IGluIGltcHJvdmluZyB0aGUgb25lIGN1cnJlbnRseSB1c2VkIGZvciBLZXJuZWwgdGVzdGluZy4N
CkluZGVlZCBJIGJlbGlldmUgSXdhbWF0c3Utc2FuIGNyZWF0ZWQgc2VwYXJhdGUgaW1hZ2VzIGZv
ciBMVFAgdGVzdGluZyBwcmV2aW91c2x5IGFueXdheS4NCg0KPg0KPiBJIHJlcXVlc3QgeW91IHRv
IHByb3ZpZGUgYW55IHN1Z2dlc3Rpb25zIHJlZ2FyZGluZyB0aGUgYXR0YWNoZWQgTFRQDQo+IGlz
c3Vlcy4NCg0KWW91J2QgbmVlZCBhIHdvcmtpbmcgaW50ZXJuZXQgY29ubmVjdGlvbiB0byBzb2x2
ZSB0aGUgc3BlY2lmaWMgaXNzdWVzIGluIHRoYXQgbG9nLg0KDQpLaW5kIHJlZ2FyZHMsIENocmlz
DQoNCj4NCj4gVGhhbmtzIGFuZCByZWdhcmRzLA0KPiBTYWkgQXNocml0aCAoVCBTIEkgUCkNCj4N
Cg==

--_000_OS3PR01MB6103A8419829A8FDDCC767FDC2222OS3PR01MB6103jpnp_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dks_c_5601=
-1987">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello Chris,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hope you are doing great.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This is just an update regarding my previous query in this mail thread.</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I was able to run LTP on security target in my machine after including <a h=
ref=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/=
kas/opt/test.yml?ref_type=3Dheads" id=3D"LPlnk" class=3D"OWAAutoLink">
kas/opt/test.yml =A1=A4 master =A1=A4 cip-project / cip-core / isar-cip-cor=
e =A1=A4 GitLab</a>&nbsp;while building the image as it&nbsp;comes all the =
dependencies required to run them.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
For LAVA, I will try to upload a rootfs tarball to cip-project's S3 storage=
 with build:x86-uefi-base configuration along with
<b>extension: test</b>. I hope I can run LTP tests on M-COM x86 on LAVA wit=
h this method. I ran SMC tests on M-COM x86 with 6.1.112-cip30 kernel -&gt;
<a href=3D"https://lava.ciplatform.org/results/1222616/0_spectre-meltdown-c=
hecker-test" id=3D"LPlnk489964">
https://lava.ciplatform.org/results/1222616/0_spectre-meltdown-checker-test=
</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of sai.sathujoda@t=
oshiba-tsip.com &lt;sai.sathujoda@toshiba-tsip.com&gt;<br>
<b>Sent:</b> Friday, November 15, 2024 7:14 PM<br>
<b>To:</b> Chris.Paterson2@renesas.com &lt;Chris.Paterson2@renesas.com&gt;<=
br>
<b>Cc:</b> hayashi kazuhiro(=D7=F9 =FB=FA=CE=DB =A3=C4=A3=CD=A3=C5 =A1=DB=
=A3=C4=A3=C9=A3=C7=A1=E0=A3=CD=A3=D0=A3=D3=A1=DB=A3=CD=A3=D0=A3=B4) &lt;kaz=
uhiro3.hayashi@toshiba.co.jp&gt;; dinesh kumar(=A3=D4=A3=D3=A3=C9=A3=D0 TMI=
EC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;; cip-security@lists.c=
ip-project.org &lt;cip-security@lists.cip-project.org&gt;; iwamatsu nobuhir=
o(=E4=DB=E1=E6 =E3=E1=E5=C7 =A1=DB=A3=C4=A3=C9=A3=D4=A3=C3=A1=E0=A3=C4=A3=
=C9=A3=D4=A1=DB=A3=CF=A3=D3=A3=D4)
 &lt;nobuhiro1.iwamatsu@toshiba.co.jp&gt;; cip-dev@lists.cip-project.org &l=
t;cip-dev@lists.cip-project.org&gt;<br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Hello Chris,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Hope you are doing well.</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
After going through Lava job definitions where ltp tests are run on CIP ref=
erence hardware on CIP LAVA,</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
I noticed that ltp tests are being mostly on:</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
renesas_r8a7743-iwg20d-q7</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
renesas_r8a774a1-hihope-rzg2m-ex</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
x86_cip_qemu</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Using rootfs tarballs such as:</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/core-image-minimal-qemuarm64-ltp.tar.bz2</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/core-image-minimal-qemux86-64-ltp.ext4.xz</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
..along with respective dtb files.</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
But currently m-com health checks are using https://s3-us-west-2.amazonaws.=
com/download.cip-project.org/ciptesting/cip-lava/rfs/rootfs-simatic-ipc227e=
.tar.gz rootfs.</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
I tried to use &nbsp;SKIP_INSTALL: &quot;false&quot; in the test definition=
 because ltp test cases are not present in expected folders, ex: /opt/ltp a=
nd dependency packages as well expecting they will be installed in the imag=
e after boot. But the job failed.
<u>https://lava.ciplatform.org/scheduler/job/1223149#L1339</u></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
I request you to help me in preparing a simatic-ipc227e rootfs tarball with=
 ltp tests and required packages and pushing cip-project s3 storage so that=
 I can run ltp tests on m-com device. Please suggest if you know any altern=
ate rootfs can be used to boot on
 m-com device.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Thanks and regards,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Sai Ashrith</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(255,255,255)">
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/core-image-minimal-qemuarm64-ltp.tar.bz2</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(255,255,255)">
<a href=3D"https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/=
cip-testing/lava-healthchecks/rfs/core-image-minimal-qemux86-64-ltp.ext4.xz=
" data-auth=3D"NotApplicable" id=3D"LPlnk343694" style=3D"color:rgb(255,255=
,255)">https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-=
testing/lava-healthchecks/rfs/core-image-minimal-qemux86-64-ltp.ext4.xz</a>=
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> cip-dev@lists.cip-p=
roject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Chris Paterso=
n via lists.cip-project.org &lt;chris.paterson2=3Drenesas.com@lists.cip-pro=
ject.org&gt;<br>
<b>Sent:</b> Tuesday, November 12, 2024 7:39 PM<br>
<b>To:</b> cip-security@lists.cip-project.org &lt;cip-security@lists.cip-pr=
oject.org&gt;; iwamatsu nobuhiro(=E4=DB=E1=E6 =E3=E1=E5=C7 =A1=DB=A3=C4=A3=
=C9=A3=D4=A3=C3=A1=E0=A3=C4=A3=C9=A3=D4=A1=DB=A3=CF=A3=D3=A3=D4) &lt;nobuhi=
ro1.iwamatsu@toshiba.co.jp&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; hayashi kazuhiro(=D7=F9 =FB=FA=CE=DB =A3=C4=A3=CD=A3=C5 =A1=DB=A3=C4=
=A3=C9=A3=C7=A1=E0=A3=CD=A3=D0=A3=D3=A1=DB=A3=CD=A3=D0=A3=B4) &lt;kazuhiro3=
.hayashi@toshiba.co.jp&gt;; dinesh kumar(=A3=D4=A3=D3=A3=C9=A3=D0 TMIEC ODG=
 Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;<br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Hello Sai,<br>
<br>
&gt; From: cip-security@lists.cip-project.org &lt;cip-security@lists.cip-<b=
r>
&gt; project.org&gt; On Behalf Of sai ashrith sathujoda via lists.cip-proje=
ct.org<br>
&gt; Sent: 12 November 2024 04:14<br>
&gt; <br>
&gt; Hello Chris,<br>
&gt; <br>
&gt; Hope you are doing well.<br>
&gt; <br>
&gt; Regarding IEC 62443-4-2 certification, the certification body has aske=
d<br>
&gt; for Kernel and IEC test results on M-COM device. Based on my current<b=
r>
&gt; knowldege, I believe that the test suites mentioned here<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-" =
data-auth=3D"NotApplicable">
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-</a><br>
&gt; /blob/master/submit_tests.sh?ref_type=3Dheads#L55 &lt;https://gitlab.c=
om/cip-<br>
&gt; project/cip-testing/linux-cip-ci/-<br>
&gt; /blob/master/submit_tests.sh?ref_type=3Dheads#L55&gt;&nbsp; shall run =
for every<br>
&gt; updated kernel image on different CIP reference hardware in LAVA.<br>
&gt; <br>
&gt; Since availability of M-COM device on CIP LAVA Lab still needs some ti=
me,<br>
&gt; we are manually running each test suite i.e SMC, Smoke, LTP etc. from<=
br>
&gt; <a href=3D"https://github.com/kernelci/test-definitions" data-auth=3D"=
NotApplicable">
https://github.com/kernelci/test-definitions</a><br>
<br>
As Jan said - we now have one in CIP's LAVA.<br>
If you have issues using it please let me know.<br>
<br>
&gt; <br>
&gt; There are no issues with running SMC, Smoke tests but while running LT=
P<br>
&gt; tests it is trying to install some dependency packages to the root fil=
e<br>
&gt; system. Currently it shows it is a network issue but even if it gets<b=
r>
&gt; resolved, the packages cannot be installed because the security image =
has<br>
&gt; read-only root file system.<br>
<br>
So you'd either have to use a writable filesystem or pre-install everything=
 into the original image.<br>
<br>
&gt; <br>
&gt; Another idea which needs to be discussed is, since Kernel tests by nam=
e<br>
&gt; means focusing on testing only the Kernel, we can try to use a differe=
nt<br>
&gt; root file system to run these tests. But this is just an idea, this ne=
eds<br>
&gt; to internally be discussed within SWG and with Certification body.<br>
<br>
There's no harm in using a different rootfs, or in improving the one curren=
tly used for Kernel testing.<br>
Indeed I believe Iwamatsu-san created separate images for LTP testing previ=
ously anyway.<br>
<br>
&gt; <br>
&gt; I request you to provide any suggestions regarding the attached LTP<br=
>
&gt; issues.<br>
<br>
You'd need a working internet connection to solve the specific issues in th=
at log.<br>
<br>
Kind regards, Chris<br>
<br>
&gt; <br>
&gt; Thanks and regards,<br>
&gt; Sai Ashrith (T S I P)<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_OS3PR01MB6103A8419829A8FDDCC767FDC2222OS3PR01MB6103jpnp_--


