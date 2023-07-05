Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A284C001B0
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 06:35:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.11136.1688538914089528374
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jul 2023 23:35:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 3656ZBaS2601937; Wed, 5 Jul 2023 15:35:11 +0900
X-Iguazu-Qid: 2yAb9zVTfCdIYBJZRY
X-Iguazu-QSIG: v=2; s=0; t=1688538910; q=2yAb9zVTfCdIYBJZRY; m=Td9Qk+zu3r9JboXZzHtqE+tftYV4bojt/Q5/cyMJiwE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 3656ZArZ1288451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 5 Jul 2023 15:35:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZMsGIIbOM6Mry850uwd0nsPGRGJk2GicO98ey6DQ7T4aozx4HASDzHCnsYpvEQ1GxRAvVaU5GltUXKKySjG1Yjt7Fq4QY5Pt21RUMNdhIwWAM8SACHPMcwIbswJ0HKQHu6JkXD/fA/zAXqleoJC5uqP3wZnNZvAkx2GnRmyL991KpjPqw1qHIt1xfsuAhH2o48ahszA92pwaPh2IZxBCK8KK8KppEj8MzfZUZnJkqnXUjqCO1Uhg3MMusGWh6cHYssl/vcbhyFe7nMMXoAEUZggMw6ubEkvma9wAWeS+BVwDspn4Awzf2vMzVO+Qb4SzylxntdW2qlMy9JG/51u8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2XWlsBsrQsdKTGFv7avPuh0tTtBMI8UaVKB09CT1LY=;
 b=MhJDm13oWToDOBo6up5NkeZ79cMTwMz/CF7uGcUpE2QeAWo+b+kw11gf0GjjF2X9X51140QdGIHHBd5vi3njwrRssROvOPp8Yuq1wYopWKQXb4JLlx0SNMn7pPb3gJpFQb+u/aiiUxOV/cLVHG/s1Ok13QIxiwAmD4+JEXqvBkVZb1Sd33pY+P3SEKXNw7T+DPU+FIQuSdfwMReRYxVeraEObQIh3rg3jq7whEmGVooNaw+VBn85LqSjChOlD/8/VuYVf3cmzVwzEulBQV8GgXUgMlf79wmHJEelMhl0pAPRMlwzgJA4qKhHOEmlNf31cCgfvGqHgT29jKGIw4T/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [isar-cip-core 2/2] kas/opt/security.yml : Change
 password to fit pam_passwdqc policy
Thread-Topic: [cip-dev] [isar-cip-core 2/2] kas/opt/security.yml : Change
 password to fit pam_passwdqc policy
Thread-Index: AQHZrwg12caq6B8Wo0W/7z3ZjM8CL6+qtRaAgAACHFA=
Date: Wed, 5 Jul 2023 06:35:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSAPR01MB494556AC87B0A5118FC7212EC22FA@OSAPR01MB4945.jpnprd01.prod.outlook.com>
References: <20230705061611.20080-1-Sai.Sathujoda@toshiba-tsip.com>
 <20230705061611.20080-2-Sai.Sathujoda@toshiba-tsip.com>
 <4eca63ad-8b8b-eced-414d-b122e039c6a4@siemens.com>
In-Reply-To: <4eca63ad-8b8b-eced-414d-b122e039c6a4@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|TYWPR01MB10522:EE_
x-ms-office365-filtering-correlation-id: aab1acb4-b9d7-4b33-fb8b-08db7d21f9f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Wldo/YhAVceQJoLYCO0iDdQR5oKQVGcEZir3kTLxBFdhbrkwB4Mq++YMOg0rzg55SFaTzlPPG17Syq+kVLJ0r1AOCJ2sNst/u3y36n4AzyXiMNSjxAur+W9RPvOwYLFCO2MPpxW8k7t6tmsYU2x1ZkFdvhRYDSDT+MsEoUzZSH5MDexlUq/HdbrDHW/2rJfhZ00kAwXWlpYd+uXOU47XURSdQaHHKvxHAEpErlHQ35WQOtoF1rRYDQy8Nmrp7JrVHGIaMr+c46PrZ8z2gSEMGAAyHMT3biAZ2VP9wG2z68g8CAzzvMolwoycEXO/xP0cReqMBwU45IOjvCJduwm0GSfay3lvYeajON4KS/xOY/YXKoTlQOBTCgPaIj1jV1w3TiglbyLJ/e8y1E1ab1S+1NRwixxB5JPGnUVUohGo1hyAU0boeE5KftN4N4RrQLKtcAdBHGJj13hPFKbFoqbntWUoPeqC5pBFAizP+xTjswJLMB7lKv3PdmByZKNXBCDS5UjZ0MQOtDHcIDJv5tmKO5NQGLcV4hjLps4mZNbAkgVX2xb/fzx0BW+vVu893gXQ/5AyjHgnb3EutKmpid0/+6+z9DqEdFuC2GXIstJpE+BS/hAAqk2d2pWduQ8aSpMT
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(41300700001)(52536014)(8936002)(15650500001)(8676002)(7696005)(85182001)(55016003)(316002)(5660300002)(2906002)(71200400001)(66476007)(76116006)(66446008)(64756008)(66556008)(6916009)(478600001)(33656002)(38100700002)(186003)(86362001)(38070700005)(66946007)(122000001)(83380400001)(6506007)(9686003)(26005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MmlVVnRtZGFoSG12K0xNY1I1cmZJNVMrU2pQYXZweW0yNklUNjBQMTNVRm5K?=
 =?utf-8?B?UC8vN2IxTHd2d0JBaWdRVzlDUzZtdkVtaFdMVUJMeFVwTnZKVXJaK2NlREk4?=
 =?utf-8?B?N0dwZkJrTDkzc2VqL1JrSzB3K0x6Y0lZMUtjeEVrSlJYdzBpVDBPaFI3eXV5?=
 =?utf-8?B?bGdqZkt1VE9iN1k5bnJ6MVk3NEh6SGtsUUJBaHZNOVZqeVUzU2ltS1Rrd1VZ?=
 =?utf-8?B?ZWQ5V0FBY1h5bGdKcWRlV1VyWmtjeTB0QUpOb3RDQ0hUcjRFUk1HTStJRDlL?=
 =?utf-8?B?RGN4cWR0Q25oMXNQZXJOdGwxdXpQeHhaU0FIbWlFRTZscDJOekpab3F4dE9R?=
 =?utf-8?B?SFdRdEpkS2tHK1U1anQ1THZhc0NSZWhsLzZ3ZkFMOEI2b1NkNkNaNTdVenlC?=
 =?utf-8?B?dzRjSXVnMnZoZEJ5THk0cC9mVE43bmRLdFFuRGtuSnE0V3lEWUtRMkEzaWZ5?=
 =?utf-8?B?Q1VGaFNGVDRkL00rM0IxcU1SK2lMSGNoNkdDNnFFKzQ0NkdCUDg5RmxwTmE1?=
 =?utf-8?B?cFhURjVuOXFuY002cDFIcmlPU3E2ZnlmSnZZcjl6LzVUWmhpZDFpVHVnT0xi?=
 =?utf-8?B?N0VOU21QbW1US2Y5bDZxa01abFFRZ25aRElsMWtOUDVIWFpxKzlhOHBDbGdM?=
 =?utf-8?B?Uk5HbVhWRU1kdFd0L3p4UzE3TnIybEFLaGV0Y3hvUCtWQnhLcWhWcFpzOTdh?=
 =?utf-8?B?bG5hYjlsYmFDOUFGS2dPRkVsVkJURXZkTEpuM3V0UTg5Q0JoSFFiK0FjN0RM?=
 =?utf-8?B?dTlJcGJCYjh3M3hzSElNd3JOZ05FaUJkbmpRQ2FzQ1J2MGpWaUVVcFFQbUc0?=
 =?utf-8?B?Vjg2b3BYeTVZcVl4NEFzUVMzOUJhS3hkQTRHMnphTjhSUHg4VzZSZWh2blpQ?=
 =?utf-8?B?L0xRcmxDVXo3TjBabVgwSWxNRHVZMHduUjFpVk12UjdsT0gwSzJvZStGTnVl?=
 =?utf-8?B?NTdzTUs4NStESys1ejF0eWFDVjlrS2t5SVdVSElTeTIvVDc1WjQ2VnZSd2g0?=
 =?utf-8?B?UFFWYWV5UkF0OHU3VjNEcDFTUGZDdDFBSlFoY0p4anJPUi8zR012L05DZFkr?=
 =?utf-8?B?VjZtdFNkcTFVYldyamFlb2pyUWdQWEdIVlBhTm14RmpKWW1Jem5DOGlUVmZm?=
 =?utf-8?B?bzRybkRtSDNnU3NYcFZ1MFE5LzB3RjRJcXk3RXE1L0dkOFV1cm5kWCtxVVNE?=
 =?utf-8?B?MVlVRWYxbFJsZzFmRnN4azdFVllnMk02d0NRcW5zUjBCWWU2a1I4S1RvVXIw?=
 =?utf-8?B?L2h2dUErNUZRbTR0aWZTS2t4U1VMVVFHNXhNYXZhMGJxTU5aRnhtenA1cFgx?=
 =?utf-8?B?TVlmSlM2SmMvYUN6T2tUSFFNM2MvYm14UGxma1J5bldITUx4UkhRZzNYN0Np?=
 =?utf-8?B?OXRLLzdJS1QvcjQzVWJSdGJEVmIvL1RrN1hoRUthZXFxZXNSOFdNU1hqbUxK?=
 =?utf-8?B?dndRdWVZNUYrK2dhNmlrb1hCSnV6WnhnTmpSeHk1bG9WZmRlMGJzNUlPZnp3?=
 =?utf-8?B?VnJYWEFCVkJlUThZNFcyRXZNRHErQ3p1b2lucnBBT1ArL1FDTzhTMk1DaXJC?=
 =?utf-8?B?UjI5S0RPcHpsTnJEdVlpVFhveG1ZOFFHSXE0bTNscmhDZmVCdWxZQ29QTSt1?=
 =?utf-8?B?SUdBWFV2M3MzVHJLR0s4aFczNlcya2pFZXFJSVFvRnUrWTJkMENKNnZ0QzJp?=
 =?utf-8?B?YW5EL2lVVW5aQTY2MWFyR0h1NWdHMjdJL2QrcUZ6QlFFc2QxcGNpK0M1WU5i?=
 =?utf-8?B?cjhYRU1qbHZoNGVZdUQxL2ExbGowSWxWUm54cE90MVlEK0Q4dFpneEhvN21C?=
 =?utf-8?B?L081ZmNUc1VjQVIwY0swQUNXMGlvTFNOSHFVVm5wMTBteHEwMjFQZXdFem9u?=
 =?utf-8?B?MHBoeUo1RWF1bUpEVzRzeEdGV293NEY1cmtqbUJFYUVQeGQySXMwRVExQStj?=
 =?utf-8?B?QXcvZHZ4ODNMY1RpVVVabGRMSm9tNHNrS2h0eVNwWld2SWNXTmVwbzYwNnVB?=
 =?utf-8?B?VzlvT2JRUDBJemo5NzBoeURIZkZOSFRaWndRei9XbmtoTzNFcll3U2czaWIx?=
 =?utf-8?B?a2Y2N1RNTEFqMGhDUkZQRGQ4dG5wWFNCQzYrMVYwaFR5cExaejVTREYvUDVu?=
 =?utf-8?B?WGRXYnQ2N0Q3MVFnT3YzQ2dVK0ZtSFRLRFRyVGtaVjhKekhxbjd1WXNpb0VH?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IayHObG1qCIGTO4+m4NfIzb4FsgTNVRFvC5i3MROAGK7QGzc1GH6U2ZFlCOQ0ZEaCxRtC6RvhzK0fh6glwivW2t81TmTnd4i60hNfnxICQ6TnQfl1NpNVeaYtXwHEpVO7wj20g03xHKJJ5K68PJL26NoOST5fNMADFQRsUD0evoyzjepQpG7nVbndoU3pVwvEGUdTMT0vSx/bJtIP062ji4E36HTOHnmWZ18SrL0381zleAgpZJt+lODE1y5svg0m+qhNajtWIMdu+VRKa0MFW4LRRVR5Uip44yl4+2SW7Spsfm0AHZJdymmbsKLbyttPTY9mXIojRJYSmAw7qfp2P+fI3L9I0+iu+5VVj/AdHQ1SRFH32Qm4/f+x/cf5BSdtw1Bg+VdDHJj2H7aO26VtxmPCdm2dlm97kr6eOCcv4f+h2742/UOIc3/EkvgYPUVjZFnXp1hskc0FsQRRtdDua2yyzsEvcVJL5ZIum55yaGyIQlXzVTs3QbV8jxAC9t4Ae4xuH1PCSXxeZy4mIM9t54tDXBd264razc+N3UHRbJ9FEFy4wlfsa0WjreN+LMAWvr9Hyf8nwrkMX5hIgtmDoNeE5tuSN4D/0Tdlq3mZ0P2hFVF1uG9gQaA8NtX86w5YJMCRfmmquEQZHyfmuv2/uNWa+sGrT4CZUG5AYwO10Q1k6zbax0dkN8KuuGi61JhWzyRe+y+Zzgd5LTFnsjlCdlMVpDhOHTPOJpEL83TjuOhKwUHl0K5KMRzHEMiADn4uf4q9FvXK9dblK/34Oqbr2RHhch9OISFE7XAYyXXNObw/aGtvIqwfj42j7e+VbUj
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab1acb4-b9d7-4b33-fb8b-08db7d21f9f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 06:35:08.3710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aKTalGniCjvHgpivxLBBRljU3ben+OLNGjI0paPf9vCS+5427sYsZzIKquQALpDZhNYnSjc8577Sorjp+os6qYEf5mKvemuVyJAgADPPn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10522
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 06:35:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12225

SGkgSmFuLA0KDQpZZXMgeW91IGFyZSBjb3JyZWN0LiBJIGFwb2xvZ2l6ZSBmb3IgdGhlIHdyb25n
IG9yZGVyIG9mIHRoZSBwYXRjaGVzLiBJIHdpbGwgc2VuZCB2MiBvZiB0aGUgcGF0Y2hlcyBpbiB0
aGUgcmlnaHQgb3JkZXIuDQoNClJlZ2FyZHMsDQpTYWkgQXNocml0aA0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYgT2YgSmFuIEtpc3prYSB2aWEgbGlz
dHMuY2lwLXByb2plY3Qub3JnDQpTZW50OiBXZWRuZXNkYXksIEp1bHkgNSwgMjAyMyAxMTo1NiBB
TQ0KVG86IGFzaHJpdGggc2FpKO+8tO+8s++8qe+8sCkgPFNhaS5TYXRodWpvZGFAdG9zaGliYS10
c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogZGluZXNoIGt1bWFy
KO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRz
aXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnv
vKfilqHvvK3vvLDvvLPil4vvvK3vvLDvvJQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNv
LmpwPg0KU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZSAyLzJdIGthcy9vcHQv
c2VjdXJpdHkueW1sIDogQ2hhbmdlIHBhc3N3b3JkIHRvIGZpdCBwYW1fcGFzc3dkcWMgcG9saWN5
DQoNCk9uIDA1LjA3LjIzIDA4OjE2LCBTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20gd3Jv
dGU6DQo+IEZyb206IFNhaSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KPiANCj4g
U2luY2Ugd2UgdXNpbmcgcGFtX3Bhc3N3ZHFjIGZyb20gYm9va3dvcm0sIG91ciBjdXJyZW50IHNl
Y3VyaXR5IGltYWdlIA0KPiBsb2dpbiBwYXNzd29yZCBkb2VzIG5vdCBtZWV0IHRoZSByZXF1aXJl
bWVudHMgYmFzZWQgb24gdGhlIGJlbG93IGdpdmVuIHBhbV9wYXNzd2RxYyBwb2xpY3kuDQo+IA0K
PiBXaGVuIGNhbGN1bGF0aW5nIHRoZSBudW1iZXIgb2YgY2hhcmFjdGVyIGNsYXNzZXMsIHVwcGVy
LWNhc2UgbGV0dGVycyANCj4gdXNlZCBhcyB0aGUgZmlyc3QgY2hhcmFjdGVyIGFuZCBkaWdpdHMg
dXNlZCBhcyB0aGUgbGFzdCBjaGFyYWN0ZXIgb2YgYSBwYXNzd29yZCBhcmUgbm90IGNvdW50ZWQu
DQo+IFRoaXMgbWFrZXMgb3VyIHBhc3N3b3JkIHRvIGhhdmUgb25seSAzIGNoYXJhY3RlciBjbGFz
c2VzLiBIZW5jZSB3ZSBhcmUgDQo+IGFkZGluZyBtdWx0aXBsZSBjYXBpdGFsIGNoYXJhY3RlcnMg
dG8gbWFrZSB0aGUgdG90YWwgbnVtYmVyIG9mIGNoYXJhY3RlciBjbGFzc2VzIGFzIDQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBTYWkgPFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT4NCj4g
LS0tDQo+ICBrYXMvb3B0L3NlY3VyaXR5LnltbCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2thcy9vcHQv
c2VjdXJpdHkueW1sIGIva2FzL29wdC9zZWN1cml0eS55bWwgaW5kZXggDQo+IDRkMTE5MDUuLjFm
Mzc0NWIgMTAwNjQ0DQo+IC0tLSBhL2thcy9vcHQvc2VjdXJpdHkueW1sDQo+ICsrKyBiL2thcy9v
cHQvc2VjdXJpdHkueW1sDQo+IEBAIC0xNiw3ICsxNiw3IEBAIHRhcmdldDogY2lwLWNvcmUtaW1h
Z2Utc2VjdXJpdHkNCj4gIGxvY2FsX2NvbmZfaGVhZGVyOg0KPiAgICByb290X3Bhc3N3b3JkOiB8
DQo+ICAgICAgVVNFUlMgKz0gInJvb3QiDQo+IC0gICAgVVNFUl9yb290W3Bhc3N3b3JkXSA9ICJD
aXBzZWN1cml0eUAxMjMiDQo+ICsgICAgVVNFUl9yb290W3Bhc3N3b3JkXSA9ICJDSVBzZWN1cml0
eUAxMjMiDQo+ICAgICAgVVNFUl9yb290W2ZsYWdzXSA9ICJjbGVhci10ZXh0LXBhc3N3b3JkIg0K
PiAgICBhZGp1c3Qtc3d1cGRhdGU6IHwNCj4gICAgICBBQlJPT1RGU19JTUFHRV9SRUNJUEUgPSAi
Y2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkiDQoNCkkgc3VwcG9zZSB0aGlzIHNob3VsZCBiZSBmaXJz
dCBzbyB0aGF0IHRoZSBidWlsZCBkb2VzIG5vdCBicmVhayBhZnRlciBhcHBseWluZyBwYXRjaCAx
PyBPciB3YXMgaXQgYWxyZWFkeSBicm9rZW4gZm9yIHRoZSBzZWN1cml0eSBpbWFnZSBkdWUgdG8g
dGhlIG1pc3NpbmcgZGVwZW5kZW5jeSBpbiBib29rd29ybT8NCg0KSmFuDQoNCi0tDQpTaWVtZW5z
IEFHLCBUZWNobm9sb2d5DQpDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0KDQo=


