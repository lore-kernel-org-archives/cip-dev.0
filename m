Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003D6C25B74
	for <webhook@archiver.kernel.org>; Tue, 21 May 2024 15:04:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.22018.1716303885703382877
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 May 2024 08:04:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 44LF4hqf1073366; Wed, 22 May 2024 00:04:43 +0900
X-Iguazu-Qid: 2yAbdMiuZ8Y1vs7wBc
X-Iguazu-QSIG: v=2; s=0; t=1716303883; q=2yAbdMiuZ8Y1vs7wBc; m=MuK7ksyvRT10Iu4R5uJ2f4be4HzhTh3tnm155Qww1tM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 44LF4gh02776618
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 00:04:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOLIMHeSGZYYu/Pgkp/if6exjJrclFw5Sj8OC++rjcjKQxStxJKTd3KXIKII4b8NgI0YGeL9Tx6HImhuNTHKw8sJt+2dnjt+rfgsuuTImL8otCFL+hKmh/KM2ZSl0KWWyyVUEyMt0zZagVlunkjgTsJ+GrGoWBoXd0dSQ2Ncws8BUU9lZs+y7w54ufLRTx0dzrnbMmk/bTB/eASoRWZv84StlYQNXmJX2BogZNqcBaWUjsvln/KlfESCI2JFqZXqKiOJWYO3TlosIeoTwoKyXlzixZloacOUyzpe5tJ/97Aes4BY/hisIdyY+Xp1oVWSGWkHQbBzPrmEoZtGJPYGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XC89Rfm902jWOUWfxTjsNAdbTY/+IhB92O1Q3U0JcTY=;
 b=adM4SmfRPqDU9PMrfoUFGQMdqdc7KIsP1nX6s2UxZ/ftYl/a70g9E/v46RrYC0WOJFfzLh0E2jDt1Tlq1o0/8cIpRWyxOAGkWat1Ravk7yhMAbZT+B1D0wzcP4GQ89BY+Kryj3xWalJk6x5Y+1D1672uAfIyC+QRdFPRDbRzuD82b+18TTDLBRa1y/qHlA09c/BeSmT/hJ3P/f3YVbOHuzz2WZCN4HyGVwENz4rQ0G2XtRx1Z9FgOPLWb5nsHjYCEuKA3hIcKttM4GU4ulPOnZ3K+hX2kPahWmuCk96611jcGiLSNNQ0oNGgAHcGdVSXtFymC/ktWFKdgWPvpsuxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <jan.kiszka@siemens.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>, <cip-dev@lists.cip-project.org>
Subject: RE: Request for updating device dictionaries
Thread-Topic: Request for updating device dictionaries
Thread-Index: AdqmtLnvothy4nUKQBSdfu8qbwxdbQD6sUBwADL8pYAAAnF5gAAD935AAAJUSVA=
Date: Tue, 21 May 2024 15:04:39 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103AFEC697CE32DA84F113DC2EA2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103F00964E26A0F5D38A8ECC2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862221FADD6EE25E032DADBB7EA2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <da0d13f4-4721-4f79-92f0-2e20b9c2e7af@siemens.com>
 <TYWPR01MB11862ECCB6972DA686F96C20CB7EA2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB11862ECCB6972DA686F96C20CB7EA2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB5863:EE_
x-ms-office365-filtering-correlation-id: 8f85548c-e74b-45ea-3918-08dc79a7569c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bStKUUV6WjNRNWU4dm8xaWQwbDQ0MXZiQjVVTTBLRTlGRWdncGo1WXhNTGNw?=
 =?utf-8?B?QUVlbEo5dU1lZ25pcTRtMElSOU9UYUcwVzZQd05OVklSNGk0ZlR5c1lLbkpz?=
 =?utf-8?B?ZlFyd1pLWlcyQ2tUa3liVXU4K2FnaDdMNitPRVdFZ0ZhM2tJenNxSmQrTHg1?=
 =?utf-8?B?VDF6K25KOFFBMkRsc1kzN1cvQ25qelFvdms0TFhzVEVXODNGMGtnalkzcFRG?=
 =?utf-8?B?UGRrdlo5S3NiMGNGSFB5YXhpQ253S2FZU1h3ZVgyVWN5anUvdkNZQ0VQejM1?=
 =?utf-8?B?TVk1UmhQcWNiRjNXaHJnQUlIWnZwb1NXZXJsWnAvWVBIckRKcXNIamRXbEp1?=
 =?utf-8?B?VFQ3NElOOFdGU3hidXorbnBiVEJvU3RnekF3YTdVMmtSZlFSL3FJVzRKVzd6?=
 =?utf-8?B?VXR4cWJ1UFdUdi9JTW96cWttSmhkUGp3d2lSaVVxY0U4UTc3dEd2VmNKKzNn?=
 =?utf-8?B?Y2Nwd04weHRnNEp3WlNDc0dKTUZwOUtiNExaQXpCUm5UM2tOV3N6dHphMlFD?=
 =?utf-8?B?ZmpDQks3c0cxajFwanJaamdHeC9RNTJ4NkM1OGJxMzBUcVdKYTF2L0l6WkUr?=
 =?utf-8?B?d0NvQ1RtcU5MOGQ4ZWxUcC9wWUE4QmxQTXIvMzloejAxU1g5TnRhR1dia1pk?=
 =?utf-8?B?S2tWeXJ4U0h4czloN0Y3MDdOZk9rdEpra0Vhc3VJbzlmTjFOaDJqR1RvWktp?=
 =?utf-8?B?VU4xZXBQaFRodUh6QTBFd1QrQURrNjZWYlZHMVpHdWlCWkluak8rRXVRRjRW?=
 =?utf-8?B?WHpUZmhoNWE4eXNtVVkrbldMQTVlMitNZUJ0TmtnTTBoR0dQTlVGemNraHlQ?=
 =?utf-8?B?QzBqMGwrS3pUWWdDRXc2b0dwUmp3YlBiTkNVdGQ3ZGJyaVhVTk1NZjRJdkUx?=
 =?utf-8?B?UVdjQnhENWlIcm5VQzZOYzRxRCtibTVwMmZ3UUxldEo0TWR3Z1M3V0hLYlFp?=
 =?utf-8?B?MzlQYmRZZ3ZzSXRhQklhSnFhb3VOb0N3SlprYmtFNy96a2pIT05QUzRodDZj?=
 =?utf-8?B?dTlRSDIzYkViRG1qTWVxclR6TjVubUhYUG1meVhpZnpuSjJwN2JlWDBMaWpm?=
 =?utf-8?B?dWtPSVFlQ1FYdlB6SDVIMERDbTVwS3dyVm40Z2JSMEZlK0VjempYK3RYYjli?=
 =?utf-8?B?QWpyNWtsUXcyTmpSME05M0FDaEdLQU9Ga05vdHV5ZVZTcGlxMmQ1c2M5U2xM?=
 =?utf-8?B?aHZVWWYrMUs1c2xmT1Y4MVBFQVUvL1FNWWxUTk9jWGRzL25adHNxNmRnTWMw?=
 =?utf-8?B?NFJ5bUduUU1yb2Y3a1JVejkyS1U2NmFLRjJWRExnT3BsVnIzR09qTGh2dWFO?=
 =?utf-8?B?L0FubmZ4cmNSZFpzRDcrRExIQ2QwczIrQ0tYVG9PTFFRazRJMFlKK3YyWWVO?=
 =?utf-8?B?Yy9lRTcvamZZR1pJaENJK014MlBCS241bVBIZnk1VmQ1Unc4Q0kwVlVGWGZX?=
 =?utf-8?B?cDN4NW0yekhUS0pNSGcvZzJjQnFlL2lxL1hRcnhHQU90cWJBK0lKeXlrdnNO?=
 =?utf-8?B?V1dMOXpvS3pGc25jNlhrTDJhd0hmRjlzV05XbVQvaW9rL0RCUHIveGpIUkpE?=
 =?utf-8?B?N21waThFeWZKaGQ0dTloSTJVZTJOeENvUDFkRzQzYmk3aHRoaUNPR0RkaHM3?=
 =?utf-8?B?YkZGdkdzWk1qVVkrRElnYW1uQXdqVFRNN3lDVFpUYnlTSVVrRmxUdENTZUwr?=
 =?utf-8?B?WEVmeDlPeEZTbWlhYkJIbGF1S2hvTXdQdFZJSkVTWGpkZDhHdTlvWDRaWlhi?=
 =?utf-8?B?RHU5b1h6aTJiRFptMXVyUmQ1Wlg4bWlPVzVTd1BsVGphdmd1T1F5VlNqbmtL?=
 =?utf-8?B?WS8ra2k4bDdWdnp3R0JoZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K0NtSXdBbkFzdDk1OWhlREdIc3ZicDBwcFJMMmd6NThKWE53cGJ4VXFTcnVX?=
 =?utf-8?B?cjFlS3VzQ2g4bzR2TlhBRDhtTGxIeUV5dVNRVjRsTDZtQjFIWFZJV1pjUWth?=
 =?utf-8?B?MHpXSGd0Zi92emFncy9yVXZjL0poYXg2WGptYVN2azFxamlsUHdMaE5GY3Bm?=
 =?utf-8?B?QUZMd1pPeXVPd3JwRGRoL3k5ZU8wK25GUVBUSmJkUzRvNGU4Z3lyTHpsdHEv?=
 =?utf-8?B?elN5OXcxaDh2SXpkNVpwdm5WY21xOGcvakZ2eHJTS2hnTzdDTjJwcjlmVDA2?=
 =?utf-8?B?L3dlUWxCWktOUEhQZi84eE9mczJGTWV5NFNDV1htS2Z2aWVDMzJVeURBV096?=
 =?utf-8?B?c2Z2MEoxSWZldmltblg2NXNvQWJNWXBxbnR2ZDJNaUdWMk9KVzc1VGN6Tldv?=
 =?utf-8?B?OTJkRGZJLytHMVh5RWdDM1h1VVhCazVQQU9uN25pMEhLOE44S2hDMUpDT0l3?=
 =?utf-8?B?ZTRsQ1dGUEtVQVk1WHdWUUdFSDJXdmZXQk5qb0UwaVc1ZWNxYkdaRGo2WnFm?=
 =?utf-8?B?dTVFN1pwRE1GbG9CVmIvNWFzM1V3VFRWdWdMSWY0MlVTeXNMRU1GM1N1Mkh0?=
 =?utf-8?B?MzlxNzU1bm1oOUVKWDVUK0UxOXIrYlFzSXB6TVRhWlFEMFVKWFNnTVdEMFRD?=
 =?utf-8?B?QkUvYkc4ZnVyVTNPeHVFeXFiU0l3QXVncU9EQmkwcFRvVTFId1JEcHhPVXB6?=
 =?utf-8?B?Vk53YW10MlVQWUJTbEI2RnRSeXlabHFJaklYbWZDb1Zoa1RMOFFidWpZc29E?=
 =?utf-8?B?UUJRMDF6MWplbWhReFFXNStsS1NTQVp5MjRRajFHMDFEN0NZRXFvV29NMG4r?=
 =?utf-8?B?dE5qMEt3U0VCS0MwTTNwRmJyUnR3QVJWN1BiNVFMeWNSTUQ5MXBIbEt6SE0r?=
 =?utf-8?B?R0o4d2VacjB2ZnJyYTlOVE5ZMjQrWngrSUlMeEU0TzRXdjNZU3B5ZlVMT254?=
 =?utf-8?B?SENCaERVN3FlQmtPZmRQSnZGYTdXVVFEczZqYlBMcEJRR1NWaUg2T3VoOXJZ?=
 =?utf-8?B?bU5UMWliSFRuT2gzOUJzcDRDWGF5NVNaS0R4aXpSTE9PRm1sc2NFM3BqWGZx?=
 =?utf-8?B?c1puSmxXb1dZK0EzbzZDZHFZcUF6TkF6WlI5aDI4bm10ZWxMVEtvVGFuTnhy?=
 =?utf-8?B?N29JNlZsS3hLQkg1NUp3Q0hZc3p3T25yTFRkK3NLS1NLaVQ2L3NNQjMyOFRO?=
 =?utf-8?B?eGh0bnhscFlQOGNaZWxaQXhENitPU25BVDg2RFF6YTFtbHh1Smcwc0RTZDVh?=
 =?utf-8?B?ZWxlQjloNkE2RGo5bHk1YWpRVUhJWUdmY2dkcnRGaE9EVlFXUnQxY3hTMi9C?=
 =?utf-8?B?QmFzY0FobldpcU1LRFlYUXlFUzJla2IxQW5zenFGekJZTFo4QW1lOXAvNldJ?=
 =?utf-8?B?a0xVYzNUeDV6Wk9xSElrYXdCU2ZXRXAwb0s3ZHl6MW9WN1dLREZaWjNXbVlk?=
 =?utf-8?B?REdYbmkwRlNQZmtabnl3TEM2d2RJbUdSTUNYdDN5ZWRBNkRTWlV2TFdmeng4?=
 =?utf-8?B?SExaeUUvblo2MzNHNTcrUkF6dTg4QUI0QmI4eUNYTTVFNTZIMHJvb3ZqelRr?=
 =?utf-8?B?WGlxc1A4bzhDQXJHejNVUUlGVmtETWl0akpBK3I3SVVoMHhvQWlScHNuTmcx?=
 =?utf-8?B?d3VyeUJjemJjVTVIU3RBeXVaV2FnTytMM2psTm9McUVPblZGY1N5QWkzQnpl?=
 =?utf-8?B?TUVYSGJyeUZneWw1S215bk9KeVpYYndIN0lYM3I0QWZxOFhKcVRpb1k1Z2NX?=
 =?utf-8?B?ZDhtTGpmM2xFOUdKYTM3NWo5cU04Wmc0TkhKaHBWNFozL1c3THN4djkyTmFB?=
 =?utf-8?B?dCtvbFJ6bEh5R0hYajdPOUszSHZLTzg0RUJyQUI5Q2tMRE40Szh0c3lJZVpM?=
 =?utf-8?B?UjdoZkZjdDFRYUs3REdieDlKaDYwdnp6VVVJUEtEaWVMdmpZNTdzNC92Zkps?=
 =?utf-8?B?VkpRc0QxQ0ZZYitDMG9oOVhnMjdOZEpVOWRQdE5FQkRrb1hqcmVwYysvZU91?=
 =?utf-8?B?M2V4bUZLMnFuUTk5YWVWZEU4TGt6RmR6RFBPWlc3K25TbDAwaDBybk1BZWZo?=
 =?utf-8?B?YnQrMUNzcWR0RW04RUIzTWFuMEhBY3oxSVg0MDRjRnU2bWJKdE9WL2Y2K01Y?=
 =?utf-8?B?RUkwZXUxNCtIWFBrTWE4ZFpqYU13ckNCTzYvYUJEWVRXKzJtbTFJeW5iMjFL?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f85548c-e74b-45ea-3918-08dc79a7569c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 15:04:39.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4dMN3C/wdvyk7w4ZEKRn/dVhIAQ4rys70Ma22OYITLWkZdndWczCqnz9oWVkYYNwHtWFc5TcxPgguhN84KFXaf9JqWMhaUDB8PjkP8gmb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5863
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 May 2024 15:04:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15922

SGkgQ2hyaXMsDQoNClBsZWFzZSBhZGQgYmVsb3cgbWVudGlvbmVkIHZhcmlhYmxlcyBpbiBpc2Fy
LWNpcC1jb3JlIGdpdGxhYiBDSS9DRC4gQXMgZGlzY3Vzc2VkLCBpdCBpcyBiZXR0ZXIgdG8gaGF2
ZSB0aGVzZSB2YXJpYWJsZXMgYXZhaWxhYmxlIGZvciBub24tcHJvdGVjdGVkIGJyYW5jaGVzIGFz
IHdlbGwuIA0KDQoxLiBMQVZBX1VTRVINCjIuIExBVkFfVE9LRU4NCjMuIFNRVUFEX1RPS0VODQoN
CktpbmRseSBhZGQgdGhvc2UgdmFsdWVzIHdoaWNoIGFyZSBoaWRkZW4gaW4gTGludXgtY2lwLWNp
IHJlcG9zaXRvcnkgZm9yIHRoZSBtZW50aW9uZWQgdmFyaWFibGVzLg0KDQpUaGFua3MgYW5kIHJl
Z2FyZHMsDQpTYWkgQXNocml0aCBTYXRodWpvZGEgKFQgUyBJIFApDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVz
YXMuY29tPiANClNlbnQ6IFR1ZXNkYXksIE1heSAyMSwgMjAyNCA3OjE3IFBNDQpUbzogSmFuIEtp
c3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT47IGFzaHJpdGggc2FpKO+8tO+8s++8qe+8sCkg
PFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT4NCkNjOiBkaW5lc2gga3VtYXIo77y077yz
77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+
OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g77yk77yt77ylIOKXi++8pO+8qe+8p+KWoe+8
re+8sO+8s+KXi++8re+8sO+8lCkgPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQpT
dWJqZWN0OiBSRTogUmVxdWVzdCBmb3IgdXBkYXRpbmcgZGV2aWNlIGRpY3Rpb25hcmllcw0KDQpI
aSBKYW4sDQoNCj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4g
U2VudDogVHVlc2RheSwgTWF5IDIxLCAyMDI0IDEyOjUxIFBNDQo+IA0KPiBIaSBDaHJpcywgaGkg
U2FpLA0KPiANCj4gT24gMjEuMDUuMjQgMTI6NTQsIENocmlzIFBhdGVyc29uIHdyb3RlOg0KPiA+
IEhlbGxvIFNhaSwNCj4gPg0KPiA+IFlvdSBuZWVkIHRvIHRhbGsgdG8gdGhlIG1haW50YWluZXJz
IG9mIHRoZSBpc2FyLWNpcC1jb3JlIHByb2plY3QgdG8gDQo+ID4gZ2V0IENJL0NEIHZhcmlhYmxl
cyBzZXQgdGhlcmUuIEl04oCZcyBub3QgbXkgcHJvamVjdCBzbyBJIHNob3VsZG7igJl0IA0KPiA+
IG1ha2Ugc3VjaCBjaGFuZ2VzLg0KPiANCj4gSWYgeW91IGhhdmUgYWNjZXNzIHRvIHRoZSB2YWx1
ZXMsIGp1c3QgYWRkIHRoZW0sIENocmlzLg0KPiANCj4gQnV0IHdlIG1heSBuZWVkIHRvIHRoaW5r
IGFib3V0IHRoZWlyIGFjY2Vzc2liaWxpdHkuIEknbSBjdXJyZW50bHkgDQo+IHNlZWluZyBBV1Nf
QUNDRVNTX0tFWV9JRCwgQVdTX1NFQ1JFVF9BQ0NFU1NfS0VZIGFuZCBLRVJORUxDSV9UT0tFTiAN
Cj4gb25seSBtYXNrZWQsIG5vdCBsaW1pdGVkIHRvIHByb3RlY3RlZCBicmFuY2hlcy4gTm90IHN1
cmUgaWYgdGhhdCBpcyANCj4gZmluZSBhbmQgaWYgdGhhdCBhbHNvIGFwcGxpZXMgdG8gdGhlIG5l
dyB2YWx1ZXMuIE9UT0gsIGl0IHBlcm1pdHMgDQo+IGV2ZXJ5b25lIHdpdGggd3JpdGUtYWNjZXNz
IHRvIHRoZSByZXBvICh3ZSBkb24ndCB0YWtlIG1lcmdlIHJlcXVlc3RzKSANCj4gdG8gcnVuIHBp
cGVsaW5lcyBhbmQgZGVwbG95IHRoaW5ncy4NCg0KUGVyaGFwcyBpdCdzIG9rYXkgdG8gbGV0IHRo
ZXNlIHZhcmlhYmxlcyBleGlzdCBmb3Igbm9uLXByb3RlY3RlZCBicmFuY2hlcyBhcyBpdCB3b3Vs
ZCBhbGxvdyBwZW9wbGUgdG8gcHVzaCB0byBpc2FyLWNpcC1jb3JlIHRvIHNlZSBpZiB0aGUgQ0kg
Z29lcyB0aHJvdWdoLg0KSSdtIGFzc3VtaW5nIHRoYXQgb25seSB0cnVzdGVkIGRldmVsb3BlcnMg
Y3VycmVudGx5IGhhdmUgd3JpdGUgYWNjZXNzIHRvIHRoZSByZXBvc2l0b3J5Lg0KDQpDaHJpcw0K
DQo=


