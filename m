Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8EBC4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 15:46:04 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.42])
 by mx.groups.io with SMTP id smtpd.web10.10389.1705074357878304820
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jan 2024 07:45:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qzJDtKLg;
 spf=pass (domain: siemens.com, ip: 40.107.22.42, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsJxaQsrLak8OFFEi8oVgfeM85uGFj+C8x2l5sWcyoDL4JJ6pFrkm3wysL8TIQ03qBHz9XqoJPPEcZy4VA7JoNmv5BVUKpHBlhcw1f3Mog06a9GqHWecOQ9wTMQ4d+BNCBpqqDxX3hRbS2ABhILNGzJd3RePWj+XQ0pegK9dTXVuEiG1BtXd7wdLoK+q7otznXXSqnHKnyzqzHj6oahKMADsapz+lovOjAciuUMc/U5n7O7ye0P1gCWXYPcqWCuVvugFGRigw6SzLP+NWxqDBgsx2y+s9wWR45fDuX4IrbMhseV+yZLkJSIazFh9CsCnDLj+jCA/zWUwh97nePRW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kd+lXYsP3YaIUlZq3910pxUJcbTs+HpogHmt0wR//ZY=;
 b=UCKAzJ5zIFFMJX+j8sm5m+wkh8oJGnYKdVUQQAS+1a7CYTCM8Fq81H25O+ourQAdBOMyPCSZpcXnIVih71v3yNbvGqT29bdKtLzo5JIez3cSqtDwekJMWIFHedRsASkjEOuKIxAwQap4ZEVlHL/crjyze21mOomxkcCvW1Z0XnDZDlHcHkmhtT0Vrbpc7064VBU9BbP0bZJM4HJgvyydn7e2gD0Src+SizvzMJqC4i1ZHtBJXN44gJKQ1El87Ec7yy4BYuH7TiOomHwlfTtLhLdKiML1EcVFglhjT8HIRG4n9jM3x22YSqD4Yy8RXBO/sJvIJwh4GvILpqaQ71q+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd+lXYsP3YaIUlZq3910pxUJcbTs+HpogHmt0wR//ZY=;
 b=qzJDtKLgkT/dfj742Z8DCDP9t1GGLhOvEX/3g+GxkFHs+oZtNZrSiVbeWmRVYVrNtkUtQ2VEq6rGrviacxth1UbtVnie3FVF17Q/K0Sl1HYeXHUOv80JyzUJV3hukGj56fkYpb/vqHE7MNJATqNE2dYYfB+7CQiam2QEC//mScyVYKBA9mLixQnZFDqhtTZkgpR4o3y9YwVsIVigIJPzIDO9vb4gwdNyd/1VJDQ6SqDgZIYBmi1GVLJyQFC1bjGQ+/v7OrzUm5JKQM8ToM1WV69TETv89yqCq3mCJpv78Go1odcNDH3n5eUVbecCweMJmNxt4CTlC0YphMu0vG0h+Q==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DU0PR10MB6341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:413::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 15:45:54 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::33ca:62e:abfc:b1a]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::33ca:62e:abfc:b1a%4]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 15:45:54 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Adler, Michael" <michael.adler@siemens.com>
Subject: [isar-cip-core]: kas-cip.yml sets a default root password
Thread-Topic: [isar-cip-core]: kas-cip.yml sets a default root password
Thread-Index: AQHaRW5txcxUFzkPTE67BDEl8SBvng==
Date: Fri, 12 Jan 2024 15:45:53 +0000
Message-ID: <4a567492e734697fa059a6fa03328b6592c7d96e.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|DU0PR10MB6341:EE_
x-ms-office365-filtering-correlation-id: 01fe3856-d916-421c-0613-08dc13858f92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +2gRLSROhjj2OUMxCSyrxgO9FFVTwdu2vyfkb91CT6Xaj4JYmbMjT8/7M7IquZFJxJaWU/qINR0DgC0pLNEU3g8uJzMdBAJuOvKO59aJmAtUXxx1QwwhCoKahhL5Ej2vkg8ca+U4Qyc528hv2IeVI2XQDXjnozB9vpZ/4pBFc7kRuXo56QrKHdFplCaNoZiVbiu5QL1adv33fVl7WH4RiwUcX+dtO+tNzuz6VX/FbcY/lSbIDjPgCnNPVFFVqmqDtN+7mMun/iX2GiMP6tBh8L0Wtkwt1DAOakGCq+LgmgRlzMeXgsWMG26Vy1GnyypumZKri0p8eqFTwmbSdXSmFh6USIIy7rm0pI3LYE8nnARK9ic2EaWoNbD8BjCfqe89UcgrgXL/xx7jEvnwWHcj0Ptz0xkeoVtM9U0oR2xklwXqm45jpjl6KcIFSJb3x8bM6GbU6EaVAcXEnTDWd2O2kvulHDUEec7kLOERpxkPORI7oDR57n25Tp/d94PHsOsozb22ib5ggSZJHGR4+NsI8qOgcRUdACvluhbqmZsCxKbKxM/gXhN4RRPWXAPH/a308Rv3F3TyMs0MiPHmBdhoQFrWYvdMXEuYtgK0Q7WXGJE7YQgltFhdLclvEpYDELH/
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(6512007)(83380400001)(71200400001)(2616005)(26005)(122000001)(107886003)(6506007)(38100700002)(82960400001)(2906002)(4744005)(66446008)(5660300002)(86362001)(6486002)(478600001)(8676002)(76116006)(64756008)(66556008)(4326008)(66946007)(66476007)(6916009)(91956017)(8936002)(316002)(36756003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TVRsa0UxYjVCd3NxYjR1TTlyZlFHNUpSdGtqeTRGaW5HMzRZd1NTbXpLVDlD?=
 =?utf-8?B?aHIzTXd3bHVrb2pYeGgwZy9jeVFzU0duaFlPY1lEclkrNEw5bGhYem9ZcGc0?=
 =?utf-8?B?QmlGUmdjTms1NEJNVWVHM1F0ZFhlNUJLcEltT2YxOVhxay84KzNkTDdDOXJy?=
 =?utf-8?B?aXQ1enZKaTVvbWk0NGMvQTd0Z3ozZmFXVXp1Nk5vcjdNZmViUndleExhNUtV?=
 =?utf-8?B?dmwvTHBnUkhueDcxdU4yWlVxN0NaN1R2ZVhEWWRDbGYwaXZ3SjlxZDVWRENp?=
 =?utf-8?B?Q0RVQjhVbGo2MFozSGhLSFpvT0tYTFJocUVJZXNGQmhwY0o5dWxnbnBKREx1?=
 =?utf-8?B?UURRNHFESEZJWWozUCthZGZwUWQxV1hVcWtTc0lzSmhtamVJcWtxclBTNDEz?=
 =?utf-8?B?RGtURC9QVWpra2RBY3VOZWxGMmw2Vi9SeGQvZnloaVJwS2lSbUYvUjZTdm5t?=
 =?utf-8?B?ZnZmSlAvMW5lWDFmbnJwT0l0a3V2S0RsYm5nK0M1Z0RLcjhQMU9zZHNSRy9Y?=
 =?utf-8?B?WHBGMkhreEoxWXdBcXV4RXBJQUwzRklrOFpNOFg4cjBVZ1BpK3R3eUhkOFFN?=
 =?utf-8?B?NS9rY0pldWpMOU4vVzNmZHVPdng5UlJMVzVTbEljRGFvNVRkSHNFaUduWnlQ?=
 =?utf-8?B?eWRLdkdRblJ0VnZmNGJYWXhWdVkvZTJYT20yTGIvV0REQXpjWjZEVUJhK0Fh?=
 =?utf-8?B?Qmpxd0xUU0tIZ1BvUmhSYmpxUEpOY2JsNlp5cllBTEtQZGFJb3NVZHpzY2dq?=
 =?utf-8?B?d3JNZUNTYTlDS2h1WlBaOXplWHozVUFONWZ6V09sYXBkQU9iYS9LWWFOaWdP?=
 =?utf-8?B?eCtFZEdNVzJXdTVjR1lkV2YzbGVkNGl6MUw1S0VCekk4ejYvK0hhZXMrZSty?=
 =?utf-8?B?c3dvK1ZVL3c4V3d6Q2ZnWnpXL0E3Tm5GNjdVTkQyb0RmQVFjYkdxcUg1ODFS?=
 =?utf-8?B?RjB1THFWQkVUNVE3OWYxSzE4dmFrS2ZwLzE5dnNlWTgvRFZHalJReHRYTFhx?=
 =?utf-8?B?UGRkd3YxbjU2ZWFiWnp6d0UvbHlNNlB4MUxhdm51dDlWNnE1c09xYlBxVHdW?=
 =?utf-8?B?RERkWGU2S0g3VDNOS3hEM0k3V3d4YWNlUkhTQkR3SkduZXVCNEs2c2xPMjcx?=
 =?utf-8?B?akJMMXlxV2gwN3BVc2Nhcmh5V25ET2lBMkkzMVVPSm5hcWtPaUxDWVRqSHJ4?=
 =?utf-8?B?TS9CSU5zSStjRGlSQjJMN1Jod05UZmhUbzd6KzgxUVFlM1dYd2dqQk8rWmxJ?=
 =?utf-8?B?ZFh4RXhKQlZUVU5LQkc0RDQ2NmVhbDZ1YnhLY0Fud2VyZThQZmN0S1Q4MHgx?=
 =?utf-8?B?ZVgxMkJPeTlyMmNZUkFReEUvSUdCT0tROFRnQ0lQZzdlbWNmWXJBR2t0eDBY?=
 =?utf-8?B?M3BWU1ZZWDJLNmpYNW1nMjJUV2RiZ3hobzFZWVZTcndGbS9UaW8vM1FrWFJ2?=
 =?utf-8?B?QUNkS1Zyc0dnWkM3TE5RQ3JreUZKVEI1RkNWdkRhNzJEck5ta0hWMEFIV2ts?=
 =?utf-8?B?VGhwdHR3aEVXQlFSVXdhOG5YTkd1bTdzY29LNVRML1hZWUxCZDZLY1dmbHFp?=
 =?utf-8?B?Q0dUNVpQcTNrV3dMV0NMWWhCSzJPdUlkVlR2bnAxWEdMOE5HSW1XRnUvQkYw?=
 =?utf-8?B?L1E1VFlkN2hEWnNlbVRINExWc1FkRWY2Q2NvZkx5RnNMZ1Jxa0o2MHdRUG02?=
 =?utf-8?B?Sjc4N3FJSFBjWnFIc0pzalNGejkzSnRVRThRU3Y2VjRKd3NpSFVrd1FBUTEw?=
 =?utf-8?B?YzFkeTJrbHZVNTFORzg3ZDBKZ0RHdGRRellFbXFNMUthRUZZNmE4KzdwZkdB?=
 =?utf-8?B?QklvMjNaZDRGc3kvcC85TjVhRENiSGhmaHZZZG01SmZRa0tnazF2VzJnNFlZ?=
 =?utf-8?B?Rlc4M2pNVk9YQmFlbUovb3F6MldjNmJyYTFncU9jRDZXMHJ3blhsbkoxa21p?=
 =?utf-8?B?WVk3cE9vNk1QZjRFR3U2T1BXVVg4RmU4dkoraE5xbnR1ekxIRUtQZ3c1eExN?=
 =?utf-8?B?YUh5bVg1dTBpcG9iTEtUVERNVmZEdmpKNW43U3FHYkMwelAyeERnVW9MU0E4?=
 =?utf-8?B?SWtFK2hkWGppcTJMdGlpY25DWlk2L1h3ZE8rQVVQRHZySndyOHRWT1VqZVRa?=
 =?utf-8?B?a3hodGZxUXZiQmVUMmpnTTBWVjFTakR6STVrMHRZbDJJVzRsMFliL1pPYmZX?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DC5CCD8C5A0ED4D99C074678182F4CA@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fe3856-d916-421c-0613-08dc13858f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 15:45:54.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+7Dswsp+B65EuMvuaRhnVlz17afeE1DsnK6HKsefh3J99kmo9rbBbIZ3rHnTp57Eg10DOOhOBsFG6ePW7uxlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6341
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jan 2024 15:46:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14353

SGkNCg0KVGhlIGthcy1jaXAueW1sIGZyb20gaXNhci1jaXAtY29yZSBzZXQncyBhIGRlZmF1bHQg
cm9vdCBwYXNzd29yZDoNCg0KICAgbG9jYWxfY29uZl9oZWFkZXI6DQogICAuLi4NCiAgICAgcm9v
dF9wYXNzd29yZDogfA0KICAgICAgIFVTRVJTICs9ICJyb290Ig0KICAgICAgIFVTRVJfcm9vdFtw
YXNzd29yZF0gPSAicm9vdCINCiAgICAgICBVU0VSX3Jvb3RbZmxhZ3NdID0gImNsZWFyLXRleHQt
cGFzc3dvcmQiDQoNCkkgd2FudCB0byBzdGFydCBhIGRpc2N1c3Npb24gaWYgdGhpcyBpcyBiYWQg
YmVoYXZpb3VyIGZyb20gc2VjdXJpdHkNCnBlcnNwZWN0aXZlLi4uDQoNClRoaXMga2FzLWNpcC55
bWwgZmlsZSBwaW5zIHRoZSByZWNvbW1lbmRlZCBpc2FyIHZlcnNpb24gZm9yIGlzYXItY2lwLQ0K
Y29yZS4gU29tZW9uZSBjYW4gdXNlIHRoaXMgZm9yIHBpbm5pbmcgdGhlIGlzYXIgdmVyc2lvbiBh
bmQgc2V0IGEgcm9vdA0KcGFzc3dvcmQgYWNjaWRlbnRhbGx5LiBUaGF0IGNvdWxkIHJlc3VsdCBp
biBhIE1DQSB3aGVuIGEgcHJvZHVjdCB3b3VsZA0KYmUgcmVsZWFzZWQgd2l0aG91dCBjaGVja2lu
ZyB0aGF0LiBJdCdzIGEgcG90ZW50aWFsIHJpc2sgZmFjdG9yLg0KDQpUaGUga2FzL29wdC9zZWN1
cml0eS55bWwgaGFzIHRoZSBzYW1lIGlzc3VlLg0KDQpCZXN0IHJlZ2FyZHMNCg0KU3RlZmFuDQo=

