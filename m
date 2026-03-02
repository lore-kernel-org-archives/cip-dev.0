Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72548E9B356
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 10:17:04 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.157418.1772446618873452082
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Mar 2026 02:17:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=cs4OxmVV;
 spf=pass (domain: renesas.com, ip: 52.101.229.58, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqFrOc7hEbcHUoMiSH8UzL7oM8HKs0L6zuLFqGDTm1spW9sMDxU/nTsG/g7rYfRmx/dZg4/uXysL/RvTDWMXa2UqXnh5GGX+nX44akjg0DdwjDMwisRfV9UofG6k5nQlZG6B9yA8V+dl4szjIfcOypnUreHlgphqFLAbPuufaE3XUrGmoWNrwC9dSeBubKkFtiYF8s56v6Gdqm8/YyEAJk3D7BhLe0fZdFStV2PBOEVxPDq6G7ixnT+muARV4Rv5dMAePR+CS2R3zGOJO6s6iPZZrS2v/PMPUj+X21acadg64J17BLTQ0QXhckiUVRAsbcVm8lB49P+oEoP/Xthn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkZ/iDud8puqNsVMYHxzfwyiZoBsZloO9KLVPvtyYZc=;
 b=BunjCUMiq/kZQxW5LsSd3i0SnzxxpYi8KpfzpPiahKnugPuI6ClIO4Yydp4070xdywuJhGS/u0U2tnPVgZv5jeghZyymh7ZUmJ+8DIZ9kaynQoVhYl4O6KgPUtGJbkSzbBqo2Jc+SsnD+t4g4RTkGnocyh3BfrGKfqcJradI6JP9L0gV0zJAcinfcmLyezii3RynE0lVspBYWwEAAG7O+dAd1fqX/PG5LXHVb1o+uhM7pvt/Qt802Bnb/iJMGy08PpAxbi7CAt2RaY932b1BYXXUwZwTo7OUDgOpfdOOSN4s15aWUe2/ROzkF2H0cePM4hsvE/RYxfC4SYC+FpGBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkZ/iDud8puqNsVMYHxzfwyiZoBsZloO9KLVPvtyYZc=;
 b=cs4OxmVVS1JOnpiAFS0Osq6DH2FwpdylN1IbL8jAySYRzTDZ6u6l2aNIpxWuF6KrZktfM8pJNiYaqENIAj0BiwgHAunYCptLkxxmdksFpAhCEPwCwpPt7GhwvLewh1Na2gMMlbjRErzI2E6/1Z1yQp+orYv2/cUta8KHvCgMfc4=
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com (2603:1096:604:165::7)
 by OS7PR01MB13752.jpnprd01.prod.outlook.com (2603:1096:604:36c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 10:16:54 +0000
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a]) by OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 10:16:54 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@nabladev.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>
Subject: RE: No boards available for testing -- everything failing on gitlab
Thread-Topic: No boards available for testing -- everything failing on gitlab
Thread-Index: AQHcqiu46lDHNCoGREOzcBNN9z9gIrWbBoqQ
Date: Mon, 2 Mar 2026 10:16:54 +0000
Message-ID: 
 <OSZPR01MB8123A601BE20627475C48AE6B77EA@OSZPR01MB8123.jpnprd01.prod.outlook.com>
References: <aaVgOTtbrrgEHL2A@duo.ucw.cz>
In-Reply-To: <aaVgOTtbrrgEHL2A@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8123:EE_|OS7PR01MB13752:EE_
x-ms-office365-filtering-correlation-id: 6e505760-2b8d-418f-32ce-08de7844d41c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 1KIszX4Ge13XWClptG0Z0xj1MX7mF/H035za0LCRkuMTyteQ4wh4J6ahEYI+gqZkTTK0wdRpm8IfwMjwMIXISHV99u6QNA5kBTIQ3sHgM5fbPScmPRutAECqCtlDk5zu1vWcmWIL1FB2U9aEkwfKNW08ZjCFC3/DTyX4Y99lDFVygD1Adk5PeMTyIfof0s7Tt9qCJ4K6WobtWTWWU2hehXNTiEGKO4TOmPrjH/24rID6p/eaX7J3g4ZHnjpT5Zi1uwbmVU05Cu4b6xR49jgwYVxKCfCa4v8KeF333zQOTluyrjS9SyGlpCzNa5tu7F5gKh4WJbQmUk1Qqqjchu3LEVK2PDVewUxnyr6vtub9bkS511cIcLs99Hjvyf2pFRcFMQ2fDRFbWbM3yLTW4OT2RUl2iZV+OgrFdLFj1wV1jU8XKsjPOh3XP5JqwPtvn9xLmZUhiDGKO1zX0mHoMssnhJ8+SySDAbcrXV4zbB1eOKrTu5g64pgoRwSHUukGuYaYiyzbRQf/NMFzl2O1ORbUI70t30IfT9Y4zIGPdLeSdN2+YV/Rw6ivXsG1bEkdIGSChZjjV9ScozF9HikA1RqpT39uE2+0W+tEXgA3DCX3+P7v/gAdsBWFyUXY/HhnRtl1hDQWLckq2Zzb7K4vBQ+5cNl9w60vvXlfeYI0vNDXAiZ5E+xIfqmwmHGle260NxnAxi5VDYfumWLoTNtJ4FxpEH6Uhj+krLMAwq1ZTK4Co5qu48vq0hu+9URTsAuEySoQESHHxft0bYgahDpwOEp2lsIDvo88flcHhgPACihbGn4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8123.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?4TcsXEIPdDF1+yjwEIYLfl09nVL72dLlkahAWcGdXJygJe2koqETupRG?=
 =?Windows-1252?Q?hMZvSbVqq1ThEmhLHg2Gxeqi4ssal+lZU1fCCENaOZaVQNk58QY1V68M?=
 =?Windows-1252?Q?b+EnAOUscyv1ki+hVn/nYLz3KypNIZK6rdcBgmGWXa11xCBcwYTLgepj?=
 =?Windows-1252?Q?/lKs+PNtaYqvZHP2wUlY8A/9F/7K9qPLtLQY9Hiwd+KLcXVJHQGuH16f?=
 =?Windows-1252?Q?zcmylWttPSGDN7pPOv/EcuB2asfiT2gjAlmvKA9LLxnWxJLQh0akyQgd?=
 =?Windows-1252?Q?aeMfhj7m3eru91Q9k7V1TfIK0zquKwykY9SsXRxcz8EdMYXLTmoxq4JU?=
 =?Windows-1252?Q?RNZQY2g4hmsOgVd4HTCUcD2ODkPzUVwWAEfJh3K4vQSJZ/HihHurV/U0?=
 =?Windows-1252?Q?PPKJcxCuowN9XOrgWrmRLbMJXoDG8MmCPp9TofXJDfCdNj2nE1Va5sGf?=
 =?Windows-1252?Q?L4gLfnpiaasqrDEHA5qgI7ST53OVyIjfYMkoCQMuZUcYpH4zSUDp1e/X?=
 =?Windows-1252?Q?5f+VcNr/WPbUBvOSn2BxJ546s7dGRZGbGxm5F+SkviIEGTmrlOA7vphi?=
 =?Windows-1252?Q?Zt6jaN1fBX4fKlVIXofGUIv1rQmo5EpoPoLUf9emXmpsmqoNVHF7aBgs?=
 =?Windows-1252?Q?3HnIH/w7BWzzDLSxxlUYIBy1dwbxKU5J7MmAdc+HdxEsBwRmvpdJ8pn1?=
 =?Windows-1252?Q?UyYJiYOHcQSQC2MDW6DHmSz5G3HkL0W3wjTDxbIZQ8SYE8ug5TZtYfdL?=
 =?Windows-1252?Q?GGK63+nopk5CeLuVArs0i3Roq4N81m2Sn2ecAtqNtzNAh5je/xvM6+QW?=
 =?Windows-1252?Q?6UFPE/P12KBbS9XVLuMeU4K0FzgARiWYSkeXeFD72jaEuGzWJBy5AVc4?=
 =?Windows-1252?Q?ssByoXmuLRLkEEADwJJKlueJHNNkwNsyIFV7d8zNnFs1v5hFCwjgX6xT?=
 =?Windows-1252?Q?DqjMu36GiHOY0S+oHtsOXWH54wn4KmVhPwCkfJ7MaXjJ2zyl8MSWoGuI?=
 =?Windows-1252?Q?6C8lDNSAKOxICsiTnrRP0Qc/RLAwDWDhvMkc2nMeM/CfphTxqFLh3OhV?=
 =?Windows-1252?Q?plG0pSTWiXQmEqpHHrILJhlru8hnfi5tqFMY3ZmwqvE8NEYRBuj3t5R9?=
 =?Windows-1252?Q?Ox4wZRm1Vdy2x32xvpegzlKvhr62wAF9jnF969H9+QaN8vnxRu9RguSV?=
 =?Windows-1252?Q?dE4ek8BN9YQHYFHIwLFQtTXURsLmODu0JqmzWgS7G5CTGpmi28nUGGDJ?=
 =?Windows-1252?Q?e0yOndlDFZOIqSEQ+FsOh7h2yZ9JvN5KecymY/pwCnBeRfAmE+yjIoTz?=
 =?Windows-1252?Q?dx/vedNSxiCAvV658fZV7f97qUp4D+5saMo3t2PxRJr8/oQ5tlcuN3QH?=
 =?Windows-1252?Q?Lx9flGn8fQQjnc87UKSWjuOLg02sYmKTkIJu96jfRXxX+Yq8YijdH4CS?=
 =?Windows-1252?Q?StFIDkGABMtaNBflH0RwITAIF3c4AXKo4Xl/bX+HBfs6/3SEHeEouGbh?=
 =?Windows-1252?Q?9RxTzzU4eQv8kTnFzJAO1+r4rVROTTXocHByVOQBJWYGfDIPu+gnpCFj?=
 =?Windows-1252?Q?DzKv6svi8l78lxmyMLj9gwuO3Nl1dk+g8d2bmRhEwnP4ievlprHeG884?=
 =?Windows-1252?Q?E/oXklzVkBQzOa4f/z+ps1GtzWO3e57g5GZsmGaSBRzLkKy4mKd9y7Qw?=
 =?Windows-1252?Q?t56w+uiykP0DKJX2qZVNpS6SP8r069fOyGFuWUQ72eK78Kaqwxmuq2QM?=
 =?Windows-1252?Q?gIUM0tAuAeadombuvGU7kLPzXRkq/E/fMt3WAeCwnbhMjjZeDbcS4a3b?=
 =?Windows-1252?Q?3UQ2KSJzTVueR8y9SC3ebAF1gUNxq+EHTSieMRatkDh07aVCaaET6naW?=
 =?Windows-1252?Q?NWTAPymwhUg4eQ=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8123.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e505760-2b8d-418f-32ce-08de7844d41c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 10:16:54.4509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/YJCS/kcDnLLuN5EWYi37cucGsarELYkrYQgxrGsK4c6RKNkfJoumldApw6VdKuka6DEhPiD5D6koaUrlRW9cg2ZaI2uUMB3s5pnbsy7Fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13752
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Mar 2026 10:17:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22035

Hi Pavel,

> From: Pavel Machek <pavel@nabladev.com>
> Sent: 02 March 2026 10:03
>=20
> Hi!
>=20
> I see all the runtime tests failing on gitlab (compilations work ok)
> -- 0 boards available.
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/235793458=
5

The CIP LAVA server is currently offline since Saturday due to an AWS issue=
.
I'm currently waiting on LF IT to investigate.

I'll let you know once it's online again.

Sorry for the inconvenience.

Kind regards, Chris

