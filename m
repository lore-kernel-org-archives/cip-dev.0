Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE41C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 06:02:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.8167.1707976917909119700
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 22:01:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 41F61sbP997770; Thu, 15 Feb 2024 15:01:55 +0900
X-Iguazu-Qid: 2yAajzvdZW6Ez7lOaH
X-Iguazu-QSIG: v=2; s=0; t=1707976914; q=2yAajzvdZW6Ez7lOaH; m=YU2pDBlzkgFxMLQ+scBhps6ACLTm5A/l+Q0sAyKOE2E=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 41F61qH53784229
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 15:01:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFy0wkS7b/PVW+ZKNTmrAeenBnNdilua4myz3eYqjNUFOG56NwX6m4LlMtAWkUw9E0z0jzV7eLJiY/chj6ddndOHwfqI1LN2cxf9xoSS+5nnzz58roR86l3n09RwtufATuGfLU743X03ioPvzfKWo+lebd+TpJwLMQ/xY0qjyLaftAGNX5pnXn8yOwXr6qZsopbIDWlG5PR3ynXXnNe8bcDLthRcKJkKJ5Dee/RH8XJBMzbedbZJUCj1onw/IKNrklcm8LPF1BEOZSdgQYf8hVItpRoRmXGh/J7514USCZ1gKWTN6DSrGVQKM1kh5lcRXiCQ2nfKE4ICi43gd3owdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwh2CgomGmH2oK2SG8eTzSnbZonu3TOY8l52kooT+3U=;
 b=Zdc6qQoVp/NW/9a/6I5/GJ7E7IqOB2KGFmc3fI00jWXbBCPCMM5kg3lNdjnvLq/1muuH8HxWOPzjlvuQfQQq2TlLrmDp9dZs+9yFmifuy829f8VVcIVAe5ZvPGklSvTvUWu73ZN33h8k45t34AndykRrwgNXq/8RHAowqL2mqdqxXp00ORCarqDm0cjOdTKbCLx49fBY1r0lig5QWYvbPYoM7fGydJ19xZkUhBKTYJ4P8JsrFYFK95Z0RSFTUug3Y5KJTGjAHpqbJh4ExHbxFt9nuOefU/Z0RxQjkHAif6q0T2SpmsmsmbM1NbMcRF4ocWK9crdEv6s6ye3Y61LQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core v3 2/2] .gitlab-ci.yml: Add condition check in
 .build_base to build v2 image
Thread-Topic: [isar-cip-core v3 2/2] .gitlab-ci.yml: Add condition check in
 .build_base to build v2 image
Thread-Index: AQHaX10+HaQm6uIym0+ZtxeqMbKB8rEKFq+AgAC/BhA=
Date: Thu, 15 Feb 2024 06:01:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103B068B261D65EA7F23733C24D2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20240214154820.3544080-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240214154820.3544080-3-Sai.Sathujoda@toshiba-tsip.com>
 <6a4bfb1e-7240-4714-8794-ac30fd1900a3@siemens.com>
In-Reply-To: <6a4bfb1e-7240-4714-8794-ac30fd1900a3@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB6064:EE_
x-ms-office365-filtering-correlation-id: ae7c9660-00d3-4bbf-be6a-08dc2deb9a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EeHkUle0axQPhAsTOK8GqObXeteWZS8K2E/rqBPV++J7W7ROx0NSGkzHgStmMbGyZfz8lR8lEbGKubB0ZYeKQYBHw3RGi2a95JOt16dHdaOgnHKoPXUaJz7NpN2tLrabhAcgfdQaVlG4beOq6Pox/W6DnEMuxhzlRbJIvnmz3IbJFwxljYR8Taaonw1O+HQTNNGvoRIhzHZxSAh3G5x7I6abApoaf3yJzn4tlGaEcNll7t8EZD7mM6XZUrtjdPX59Wl/H1T39knGuxch4NYemQXXmNg3vnYYXyKSmlflv7EGOJa1RRXCMhvdkKrF54yKVo3uwFPWn6yNgtnfjSfKv70O8C7razBictW8Z5NXr8EjBLbLbeFMEBqCFxtrgpJB603as3//+NkSj9oo/hE6Gp0BrOPMae33NNj/3nXPtXJ7lk25mbIVVGde7Njz67r//mvnKmFcyktTKPV07Xdu+UxS92iYyO3xf/xZf2meFeaFuEaORLrod4MZTpMI8KzHlZwHngvoGKRf52E5wyktr46DF4CqKzNvg2cl/WPmlmC/jsL0WdI6q2hX42Ya13I8MbLGvxSb3gR9AAhCu89lgQvBylkgYTfrLtuQXWNvvzo5ETRhuMIy2RzBgewzuZXB
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(2906002)(4326008)(76116006)(66476007)(66946007)(66556008)(66446008)(64756008)(52536014)(8936002)(8676002)(107886003)(33656002)(85182001)(122000001)(86362001)(38100700002)(38070700009)(83380400001)(110136005)(478600001)(53546011)(54906003)(7696005)(9686003)(6506007)(316002)(41300700001)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cjFhMWhZRXdOZytZeEFOdHJ1UEE5WkVqOTBKbk1acDJ6Q2paSkdXZmdyNnc4?=
 =?utf-8?B?VkVaUWlWcEkraVBMUE9weC9jMzVyUUtYQzBLR3hNeGk1MTJqUis1L1J6T3Vs?=
 =?utf-8?B?eEJuWTBoYXQyS2lHbjNkUFVIV0phUklXSDUzbFhyNG5YOVJJNnMzUUMvOTl4?=
 =?utf-8?B?UVltYklGalBJV1V1ZHJDMGxQRW5ETVNsUStWd1phRWhoM2VhMWpBcXpiU29F?=
 =?utf-8?B?cGFDUENaNlNHRFZIQit6eTE2bjJsY1gwU3pqNUJTVGJmMUI4cWh6Rk16eXZY?=
 =?utf-8?B?RGFqYS95cndVWkVTV094ZzlUSlluU3lnM3FzTGVXVTV4cklNSUExRnRUOWNK?=
 =?utf-8?B?UDc4T2p6QXdHdkdHdXpSNVlvTlMwK0E0ejk3U1M4TXlpOVMwWjJDdHVWdWEy?=
 =?utf-8?B?S012b1pOYTQ3MGNqdzN1Z2dKZTBtb2FBVkdpclVOUVRJanl5d3RjWkcwOFBQ?=
 =?utf-8?B?b3JGTVRwcXF0ODJ4ckxLTS9BN0dvbTBlcDlKbTl0YW0vVmdlb1l0K0g1aWxB?=
 =?utf-8?B?enFsOTRta09VUkxha2hHNmdEWHphalBNZkUrOUwzMkZXRmdjRWNUTStHV1Zh?=
 =?utf-8?B?U0FCOTNBWTk2ajhZMG9hSkJOYXd2Q1kzQmtaLzJ6bGhycDYxWmRSb2hKZlhy?=
 =?utf-8?B?SElBcFlndnVhdnExUENQQnJKUmJiSTh2NGdDSlNnaUovZVh3UnR2clpOWjJB?=
 =?utf-8?B?WTNBQUl6cFhENUhvUmo1WGEvenJWaUhna1ZTMDZvdXVoSUhGZGlnMkVuMDZZ?=
 =?utf-8?B?OTlaY0NnZW8vbUxOdEtUK1NGb3l1SWRlQlJaVERobHgvWDRxVVBmR2oyQ2tt?=
 =?utf-8?B?dEVVQUVMdmZYMFI0Qm9xdjRadFJhSkF1T0ZlOUNqNmtaM1UvdjVmdTE4VjVr?=
 =?utf-8?B?Z1VLWUt6dlBPMmFnQTR2eFpXNFpobXllQk1PWHBrdWlCZEtqaHdoL2E1ZTcx?=
 =?utf-8?B?MmJQbWxwSHBNWkpkRmNzaVdzT3FVWWhCbStlMUgyRjZlSFNpcHVYWm1NdzBi?=
 =?utf-8?B?ekthTXNKSXZFQzVJNGpzSUF3bStwbnZlMitEUXBCZldZRlVFSnJ3RnJPWnB0?=
 =?utf-8?B?NEQvZmRFWDh1OEpRc3ZSaXk3TU1lcDR5ejB1VTZFTElXN3dLN0REUitjSWNt?=
 =?utf-8?B?MjczOVB1cUJwRmtOV0wxV2ZZelhiQU1FdndkbFArbThPSjRJODlvek1BM2Q5?=
 =?utf-8?B?bFEvbnlaNVhXdlpoZFZzd09CT1lFb0hldStqRkRjQ0FUcHQ2TnNNL0FPMlox?=
 =?utf-8?B?bk53dlh2M1F0RmNEVzF4ekpHR3NKUjFTa0F0N1dkMFdEODlvRkpwNnBwdk9m?=
 =?utf-8?B?WE5jd1A1Vk52UjhxaEpEZHo5ZlpIQjUrNzQ2NGlONUI4NXpvNmhMNEprc1Ru?=
 =?utf-8?B?UUREWllXVWFjVkdpaVBUb0FaWVJRRE1NNjU2Y1B5Nit0OWdBdVhHQWlIUjdK?=
 =?utf-8?B?VnJ3TFBEM2huWGRpMzRDcUlWOEErTit1bzYxQVlyTW5XdTBYNUFJMjM1bXhx?=
 =?utf-8?B?TXFjNFpERTNObUNrVEJSUmd1SzN0QXJleUtqOVBsL1lNdVhCaDRsNG1aYXlT?=
 =?utf-8?B?L0NHbHcxMHJjZUgrS2hCSGxvNUZuWmtYUlA0VU40VWhGZHFmZHZQMVdZcnFs?=
 =?utf-8?B?aVg0VGw5elIwV2N6QmlzRHR2Tm9ZMUY5aG5CVmUyaHo1T2RhSytXd0RYNU5D?=
 =?utf-8?B?ZVFhSEpIeEwwK2E0Yk5ySE02QXZHWGtaWW9LVHp6SWRQa1dzTDNyVEJPVk5S?=
 =?utf-8?B?andKbWxtWUpyZ0xlYWVWb3JReVVSQkVMcjVYcTBOVU43cU5zOVd4NEVqSmlx?=
 =?utf-8?B?VEN5dHBOVmUyU0VhZGd1NktlUXlXTlBGNnc5Q1dzKzFvRTkvUDhWeEluZHJ0?=
 =?utf-8?B?MHhPR1RwVkRKSmVhTEZ0R1AxdWVqWGszUElpU2ZCYlRYQU5aZ1dRVFI4Y1Zq?=
 =?utf-8?B?Tyt1bUNYYWorMmprSHFYNzNxZGY4TWd3TGE5WUhYeWVjRzFKbGs2cG42Q0Mv?=
 =?utf-8?B?NjN5REpxa09rSytiREtnVUtpN0xyRVQvaHFrWnhTeE96eis0WW1zY3A3clMw?=
 =?utf-8?B?bzZ5UkI0bjB3RUl2ZE9taEVIQ0kzNUZaMzk5SlI5NEhVUmw3cWpaVHZXZTdy?=
 =?utf-8?B?MnpGVVpDNGZ6Rlk3MG9FcGpCeGxBdHBiL1FCQjdsQnVyUXVNTGhYVnR4aWlM?=
 =?utf-8?B?Z252Z3FTTFVaZHZLc2JLdnZ3TWlJQjNST0Jub2R0a1BSaUMrMXJwcSs0SmZ3?=
 =?utf-8?B?MG5YYlBibEI2T0hXZmpFNmZJcjJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7c9660-00d3-4bbf-be6a-08dc2deb9a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 06:01:50.5798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nilp2IBKHEYmrY1dHQ7+VBgUtmYpOA5hf1QcY5Ng9A2oDc574H/aik4iJQSdt7AKfuzyWucqT9TuJUHUn6gvjmJMfuOzsG7C6j8nh6MYaao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6064
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 06:02:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14985

SGkgSmFuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMuDQoNClVzaW5nICdidWlsZF9z
d3VfdjInIHN3aXRjaCB0byBkZWNpZGUgd2hldGhlciB3ZSBuZWVkIHRvIGJ1aWxkIHRoZSBzZWNv
bmQgaW1hZ2UgZm9yIGl0J3MgLnN3dSB3aGlsZSBleHRlbmRpbmcgLmJ1aWxkX2Jhc2UgaXMgbW9y
ZSByZWxldmFudC4gV2UgbGwgbWFrZSB0aGUgY2hhbmdlIGZvciB0aGF0LiANCg0KQW5vdGhlciB0
aGluZyBpcyB3ZSB3YW50IHRvIGNvbXBsZXRlbHkgb2NjdXB5ICQ2IHBhcmFtZXRlciBpbiBib3Ro
IHRoZSBwbGFjZXMgdGhlIGRlcGxveS1jaXAtY29yZS5zaCBzaGFsbCBiZSBjYWxsZWQgZnJvbSBu
b3cgc28gdGhhdCB3ZSBjYW4gYXZvaWQgY29uZmxpY3QgaWYgc29tZSBvbmUgd2FudHMgdG8gaW50
cm9kdWNlIDZ0aCBwb3NpdGlvbmFsIHBhcmFtZXRlciBpbiB0aGUgZmlyc3QgY2FsbCB0byBkZXBs
b3kgc2NyaXB0LiBGb3IgdGhhdCB3ZSB3YW50IHRvIGRlY2xhcmUgYSBuZXcgdmFyaWFibGUgbmFt
ZSAnZGVwbG95X2ZpbGUnIHdpdGggaXQncyBkZWZhdWx0IGFzIHdpYy4gV2Ugc2hhbGwgdXNlICdk
ZXBsb3lfZmlsZTogc3d1JyB3aGVuIHdlIGJ1aWxkIHRoZSB2MiBpbWFnZS4gV2UgY2FuIGFsc28g
aGFyZGNvZGUgIndpYyIgYW5kICJzd3UiIGFzICQ2IHBhcmFtZXRlcnMgaW4gZGVwbG95IHNjcmlw
dCBjYWxscyBpbnN0ZWFkIG9mIHVzaW5nIGEgc2VwYXJhdGUgJ2RlcGxveV9maWxlJyB2YXJpYWJs
ZS4NCg0KSSBhbHNvIHdhbnRlZCB0byBjb25maXJtIHRoYXQgSSBhZGRlZCAgIC0gPiB1bmRlciB0
aGUgc2NyaXB0IHNlY3Rpb24gaXMgdG8gcnVuIG11bHRpcGxlIGNvbW1hbmRzIGFzIGEgeWFtbCBt
dWx0aS1saW5lIGJsb2NrLg0KDQpQbGVhc2UgcHJvdmlkZSB5b3VyIG9waW5pb24gb24gdGhpcywg
SmFuLiBXZSBsbCBzZW5kIHY0IHNlcmllcyBvbmNlIHlvdSBjb25maXJtIHRoaXMgYXBwcm9hY2gu
DQoNClRoYW5rcyBhbmQgUmVnYXJkcywNClNhaSBBc2hyaXRoIFNhdGh1am9kYQ0KDQoNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2ll
bWVucy5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxNCwgMjAyNCAxMDo1NSBQTQ0K
VG86IGFzaHJpdGggc2FpKO+8tO+8s++8qe+8sCkgPFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lw
LmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogZGluZXNoIGt1bWFyKO+8
tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAu
Y29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfi
lqHvvK3vvLDvvLPil4vvvK3vvLDvvJQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpw
Pg0KU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlIHYzIDIvMl0gLmdpdGxhYi1jaS55bWw6IEFk
ZCBjb25kaXRpb24gY2hlY2sgaW4gLmJ1aWxkX2Jhc2UgdG8gYnVpbGQgdjIgaW1hZ2UNCg0KT24g
MTQuMDIuMjQgMTY6NDgsIFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4g
RnJvbTogU2FpIFNhdGh1am9kYSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KPiAN
Cj4gVG8gcmUtdXNlIHRoZSBidWlsdCBhcnRpZmFjdHMgb2YgdjEgaW1hZ2UsIHRoZSBjb25zZWN1
dGl2ZSBidWlsZCBtdXN0IA0KPiBoYXBwZW4gaW4gdGhlIHByb2plY3QgZGlyZWN0b3J5IG9mIHRo
ZSBqb2IuIFNvIGlmIHVzZV9zd3UgaXMgZW5hYmxlZCwgDQo+IHRoZW4gYSBjb25zZWN1dGl2ZSBi
dWlsZCB3aXRoIGEgbWlub3IgcmVjaXBlIGNoYW5nZSBpcyBkb25lIHRvIGdldCBhbiANCj4gLnN3
dSBhcnRpZmFjdCBmb3Igc3d1cGRhdGUgdGVzdGluZyBpbiBMQVZBLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogU2FpIFNhdGh1am9kYSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KPiAt
LS0NCj4gIC5naXRsYWItY2kueW1sIHwgMTAgKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS8uZ2l0bGFiLWNpLnltbCBiLy5n
aXRsYWItY2kueW1sIGluZGV4IDRmODdlYzMuLmJiZDUzNGUgDQo+IDEwMDY0NA0KPiAtLS0gYS8u
Z2l0bGFiLWNpLnltbA0KPiArKysgYi8uZ2l0bGFiLWNpLnltbA0KPiBAQCAtMjUsNiArMjUsNyBA
QCB2YXJpYWJsZXM6DQo+ICAgIGR0Yjogbm9uZQ0KPiAgICBkZXBsb3k6IGVuYWJsZQ0KPiAgICBk
ZXBsb3lfa2VybmVsY2k6IGRpc2FibGUNCj4gKyAgdXNlX3N3dTogZGlzYWJsZQ0KDQpBbHNvIGhl
cmU6IG5hbWluZy4gVGhpcyBpcyByYXRoZXIgImJ1aWxkX3N3dV92MiIsIGFuZCBkZXBsb3kgaXQs
IG9mIGNvdXJzZS4NCg0KPiAgDQo+ICBzdGFnZXM6DQo+ICAgIC0gYnVpbGQNCj4gQEAgLTY2LDYg
KzY3LDEyIEBAIGRlZmF1bHQ6DQo+ICAgICAgLSBlY2hvICJCdWlsZGluZyAke2Jhc2VfeWFtbH0i
DQo+ICAgICAgLSBrYXMgYnVpbGQgJHtiYXNlX3lhbWx9DQo+ICAgICAgLSBpZiBbICIke2RlcGxv
eX0iID0gImVuYWJsZSIgXTsgdGhlbiBzY3JpcHRzL2RlcGxveS1jaXAtY29yZS5zaCANCj4gJHty
ZWxlYXNlfSAke3RhcmdldH0gJHtleHRlbnNpb259ICR7ZHRifSAke0NJX0NPTU1JVF9SRUZfU0xV
R307IGZpDQo+ICsgICAgLSA+DQoNCkp1c3Qgd29uZGVyaW5nOiBJcyB0aGVyZSBhIHRlY2huaWNh
bCByZWFzb24gdG8gdXNlICItID4iIGhlcmUsIHJhdGhlciB0aGVuIHN0YXJ0aW5nIGRpcmVjdGx5
IHdpdGggdGhlIGNvbW1hbmQ/DQoNCj4gKyAgICAgIGlmIFsgIiR7dXNlX3N3dX0iID0gImVuYWJs
ZSIgXTsgdGhlbg0KPiArICAgICAgICAgIGVjaG8gIlBWID0gXCIyLjBcIiIgPj4gcmVjaXBlcy1j
b3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1cml0eS5iYg0KPiArICAgICAgICAgIGthcyBi
dWlsZCAke2Jhc2VfeWFtbH0NCj4gKyAgICAgICAgICBzY3JpcHRzL2RlcGxveS1jaXAtY29yZS5z
aCAke3JlbGVhc2V9ICR7dGFyZ2V0fSAke2V4dGVuc2lvbn0gJHtkdGJ9ICR7Q0lfQ09NTUlUX1JF
Rl9TTFVHfSAke3VzZV9zd3V9DQo+ICsgICAgICBmaQ0KPiAgICAgIC0gaWYgWyAiJHtkZXBsb3lf
a2VybmVsY2l9IiA9ICJlbmFibGUiIF07IHRoZW4gDQo+IHNjcmlwdHMvZGVwbG95LWtlcm5lbGNp
LnB5ICR7cmVsZWFzZX0gJHt0YXJnZXR9ICR7ZXh0ZW5zaW9ufSAke2R0Yn07IA0KPiBmaQ0KPiAg
DQo+ICAjIGJhc2UgaW1hZ2UNCj4gQEAgLTEwNSw2ICsxMTIsNyBAQCBidWlsZDpxZW11LWFtZDY0
LWJhc2U6DQo+ICAgICAgdXNlX3J0OiBkaXNhYmxlDQo+ICAgICAgd2ljX3Rhcmd6OiBkaXNhYmxl
DQo+ICAgICAgdGFyZ3o6IGVuYWJsZQ0KPiArICAgIHVzZV9zd3U6IGVuYWJsZQ0KPiAgDQo+ICBi
dWlsZDpxZW11LWFtZDY0LWJhc2Uta2VybmVsY2k6DQo+ICAgIGV4dGVuZHM6DQo+IEBAIC0xMjcs
NiArMTM1LDcgQEAgYnVpbGQ6cWVtdS1hcm02NC1iYXNlOg0KPiAgICAgIHVzZV9ydDogZGlzYWJs
ZQ0KPiAgICAgIHdpY190YXJnejogZGlzYWJsZQ0KPiAgICAgIHRhcmd6OiBlbmFibGUNCj4gKyAg
ICB1c2Vfc3d1OiBlbmFibGUNCj4gIA0KPiAgYnVpbGQ6cWVtdS1hcm02NC1iYXNlLWtlcm5lbGNp
Og0KPiAgICBleHRlbmRzOg0KPiBAQCAtMTQ5LDYgKzE1OCw3IEBAIGJ1aWxkOnFlbXUtYXJtLWJh
c2U6DQo+ICAgICAgdXNlX3J0OiBkaXNhYmxlDQo+ICAgICAgd2ljX3Rhcmd6OiBkaXNhYmxlDQo+
ICAgICAgdGFyZ3o6IGVuYWJsZQ0KPiArICAgIHVzZV9zd3U6IGVuYWJsZQ0KPiAgDQo+ICBidWls
ZDpxZW11LWFybS1iYXNlLWtlcm5lbGNpOg0KPiAgICBleHRlbmRzOg0KDQpKYW4NCg0KLS0NClNp
ZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg==


