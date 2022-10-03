Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82185C433F5
	for <webhook@archiver.kernel.org>; Mon,  3 Oct 2022 09:57:19 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.106])
 by mx.groups.io with SMTP id smtpd.web09.17329.1664791032192738895
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Oct 2022 02:57:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=hAh2vn/A;
 spf=pass (domain: renesas.com, ip: 40.107.114.106,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITlEPudWrbqIk56wahHxZosqj53L+50ZlISN3N9o5fGqsyZtravrcQSm8o3glkQnjIvxJoiSvm4Cee6swOkK4BQzoHO4s1y5iHMBGgOrTa8abDJBYgqzvnbyQoX6P7iQCLVx8L2o7bip6RRlI+GbI9xCWYczxrqjR7Wnh9rDsVGm/DYBj8Fp8pt2HzFp0iFPCK0SQwsCby+khOSztFohxZ/qnPuVjJqW5bbXgeQfIwiKnuO8g3rAXEoicgG4m5UJGitcV6iC70CNLwakatAxepL28lE0V6WwgqYRJoYecvLs4MPqJxP/UIi1hRS1f97rcD7ps67iZmf6oZKj+b4j/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUsuNJjQLBoqXpvbdVI/jB+ECVRmXF56Z0QTYEs/Zrs=;
 b=RD6DMy3wdfFA8ec3mYqWH6us1HTcl2Dw67vt5uQPqAi1jZh6rso2msZDQsOZlQJLgHmIRQOg5jEkYzWKBWIs75skDAApS8oYUCxhuQj+NfdOoEn1wcyC99KkW7KpUpzd7eVBfwouIS3yEarVmuHdtr/YwzIT1BcJby22TTfgSThaN5BAKdCV0nCbImbpMEQEWOlY3T5rPYZxqQlZq3jEJSjeHi4cXwEXP6nx1/IdN9avSmqApAk2GFNwPN3zIBPsVqVB9ylC81Lb7PJoY0224jQDEbtlqbzoGukHaPUpptyiq3lhCiZKOBlookZn2SBLlU0wSZBYaB19YzJx1zAj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUsuNJjQLBoqXpvbdVI/jB+ECVRmXF56Z0QTYEs/Zrs=;
 b=hAh2vn/AB57M48w+ruxNsd/u9RT++e7RTkIUWxwuqZb2JNzZ/YmOVVc//AGHkrv7jf9iPBhvR6Q8lSni4EDXyN8tWtYWW65pRQHW6pA8pPBmlnJQEc0xaRj6S+R4WS+nfvtANfSxi72zQ7l5Kz4i7xUH0oBPThnfntxwrXhEsrw=
Received: from TYYPR01MB10594.jpnprd01.prod.outlook.com (2603:1096:400:30c::8)
 by TYWPR01MB8512.jpnprd01.prod.outlook.com (2603:1096:400:13f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 09:57:08 +0000
Received: from TYYPR01MB10594.jpnprd01.prod.outlook.com
 ([fe80::24e9:5220:bb15:e6d2]) by TYYPR01MB10594.jpnprd01.prod.outlook.com
 ([fe80::24e9:5220:bb15:e6d2%3]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 09:57:08 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "phil.warkentin@paradetech.com" <phil.warkentin@paradetech.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Mailing list
Thread-Topic: [cip-dev] Mailing list
Thread-Index: AQHY1ToVWjbFs0pPTkGc8R1UkTcTRK38caDw
Date: Mon, 3 Oct 2022 09:57:08 +0000
Message-ID: 
 <TYYPR01MB10594015D51E618B68D97E812B75B9@TYYPR01MB10594.jpnprd01.prod.outlook.com>
References: <94426C99-AE5B-4940-81BB-DD7080F98B9C@paradetech.com>
In-Reply-To: <94426C99-AE5B-4940-81BB-DD7080F98B9C@paradetech.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB10594:EE_|TYWPR01MB8512:EE_
x-ms-office365-filtering-correlation-id: 53357712-c93d-46f8-f0c6-08daa525a259
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fAQ7uzMU6AmWOxSslNrY0M/MpcmpMeHfGLF6gvKyVc21wetkQKOxv7eTHqxX54kBDblO75Nu24LvMCHfR+AemdYgCZB2EGBizKCIKhAf0TsSttiaaLnzF8SQInf6OHkD848vOYy65jQgxeBEtlgiG4U6zw2PIML+Amc96Bz/ohTnnM1ENxHyn7V7TTMfRys7a52rYbI/Ys3dUyo5F199nB6NOWXG2dQdCdWNWBIrQAIlvRuCX4b1WD5iAp/Elj95NAurFcNO9mehv3Jku8BmwbSZ+TBsEt0j7pQC2F2liV21VAwbV8yywa89sqBkmZfVVxwcQJzNxvzsdNqfDNiIIt6mWsmCw0onDep/kfWQ9olR5ZpxyUMs+npti9FcfUskweRSPEHONp5UK9Vj0/Lw6P+2Yz4P+hvijcOUl8OfT85eN3C+6vD3khMLsVb1J1u+hF6ZTrP1hBvgHXgYRW2VvTKboCYUnkuUq5YjkaT42M+sgMYZ5No2bvbwXveftfNI+3SIKZGBCdpt1kNND85ak+fQpHAYNONAsz3xMtRKtZvcBr1Xix0oEJshSxpx1m6wC6n/ZDT1YJizsyaXWLuuI1zgxKcrQyWMCTJjVZv2jRhSiuUticaCcjFjOztsYq+1QcwqdFMciXqXtl3VwBCtlzIyFGL7s63RHuvDRTrpjx4ws4GyhuTfswOVjO80/IQ7kPmSGOnChijk+11oWVd+QJN4ydRVb+RwByTHCi1F572OrCsiDZ9GyZEjXyHElw0GhPLl+sBRoWDA/ue47Zum3+Z2FoUrr3Zmdzvas26MuY08Ma8BVjPmYVeqWyhGxFKS5HYLdBu8iqkn/TkGPpUx1eN4Iyy6Lp7FgO70M6REVCw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB10594.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199015)(8936002)(41300700001)(66556008)(76116006)(66476007)(66446008)(66946007)(4326008)(8676002)(186003)(122000001)(33656002)(2906002)(83380400001)(64756008)(52536014)(7696005)(6506007)(55016003)(4744005)(86362001)(9686003)(5660300002)(38070700005)(26005)(38100700002)(966005)(71200400001)(6916009)(316002)(478600001)(223123001)(130980200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?hsxWP+p73RG6VgxTWZ5uf/Ln9C0rbLJL+1pE8p/eGdweVpRR3oO1Ndmv?=
 =?Windows-1252?Q?hasx2zRvffZze3yD9zSYGI2Bupq6yu01aWsdvaQJmJWnufUZmC3LAQ3s?=
 =?Windows-1252?Q?QwpoIfMQsRj6YVwsEp8NOocWLnp0MRI7G9FJoQ/cu385LnWz811abNMn?=
 =?Windows-1252?Q?o37h/1M83605aUMXUIwKsCNcIO0MJELJfyKVxZTjTbfrtJcuhuWbMJaR?=
 =?Windows-1252?Q?FSIRYxrzBNRBuFQvC9X+V6oS5tQV5qEf1boYzIazHJ8QzYuyxCs9+v+p?=
 =?Windows-1252?Q?RHv1SZpykgumOsNgPhoqjn6Z30iBWlvBzJrDeJWfkSFZJ++0jZUt+ZBN?=
 =?Windows-1252?Q?DpuYxiUvZJE6E4D+Ezxe00hRjB3oJMEN64w+7eoJraJ/ANvIEz2kHLv4?=
 =?Windows-1252?Q?CKuCfdYmY20VQfGndA786hz3mFOhJPPx8Yuy6mHoX+H525Pfw9HDKgr8?=
 =?Windows-1252?Q?Q3E2YrGa5mrkh8w1xtpCJ+CmWG8HFArWmOFKf/AVwSzJMoTe9QGM5dMy?=
 =?Windows-1252?Q?JUZDOlAqs+GdYIkRcirz3btBwCgdxT7ADocfcZ0/TD4CX1+WD+nNeuyE?=
 =?Windows-1252?Q?FWqxKAfH8C/KAVrRkDRBpjC6+zTeBNeg492difYaA2Dz3U5iuQhwG8U8?=
 =?Windows-1252?Q?TevCVfMywnsbMnxTU0Nmg//N9VPDGozEQMnHAGau1AcQWYYDPhhHwSaA?=
 =?Windows-1252?Q?rsZMg7sCaKzT4qokz0R7I6bGJq5bU2srQcxzZn0jKMENNaw0yG249/zg?=
 =?Windows-1252?Q?1GaV/f+RffxEwtIazabXpeRN8z1Q/s+9c/3FZJlmigYo70GwMVRJRCIZ?=
 =?Windows-1252?Q?uTrKq7R0GTXoteWdzmnwpnGFubjMaGIEBqPg3eCUyKCnvy5wtP6e3+YV?=
 =?Windows-1252?Q?qPjUHfEQPEdp8/RRa6JdwbIx7/o5HG/8wiTnvU1fFNMCqV48jS4HrybG?=
 =?Windows-1252?Q?Dmfkx1LjZgLJ9wctLIe/M/WUxfXlDUGxsMjGEvxubzoWJikKN8ZTUp14?=
 =?Windows-1252?Q?/lK7DYPja+UqSjys8VaMiAGpkUDfBlTCHD+MbzjH2nZJqE1YBDprLwmZ?=
 =?Windows-1252?Q?8lbBrk6ell59U9XeqzPQU1AOvzVYMYhWa9adDk9R9sosvsDvzYXbxoMZ?=
 =?Windows-1252?Q?TXjbh50FJBkAydsrIjZQwEA7urGw8W2ZxmDlm6pRu8BSdTIe3ajb+wsu?=
 =?Windows-1252?Q?OsYWSuNPMT4D/YsJHEhEBaazFcPLmEqmW1ViQJzZdXYiYQZu7LgeF0lF?=
 =?Windows-1252?Q?5LZS/NBxbDsp59QswIO2zVX+PqK1nw1dvRXaPz/11jvZ8LC6Q8wql0be?=
 =?Windows-1252?Q?pquT0kaCatI89LgobZxRZBk3fhrMpIoEHtMKm1NcfNWgtcWGCzK5VmHc?=
 =?Windows-1252?Q?hFqszFDVDsgD/tX8QERdbV0GjbSGM+wb2kjYVucF2fb9QeU/6Klt7zCv?=
 =?Windows-1252?Q?ydeyDrnuzPF0PdRsbXfy5L5bfWhe7Bp8lCrbWtYlFgSM681gh+GHRgsL?=
 =?Windows-1252?Q?y4eFlsfPsQMm9Xpn1d2Op5JcBZ+YIGcma5iojrGBhhwrFuET5bsDNAKs?=
 =?Windows-1252?Q?NB+q77XYzQX8CKxJUKa9j4bDIvvIJT7dJAHimMqSK+BNHWZXTGO6QmYj?=
 =?Windows-1252?Q?o7JzPN6scnt7ek0NkZZkQcZRFPuKSVpWJM6I3R9mZ7FJB7ObK38IBRst?=
 =?Windows-1252?Q?YUWmMrbTQo745Ot8lWyiWTmajilfRk6KWVvEPThy5wBF3BPvP1jUxg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB10594.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 53357712-c93d-46f8-f0c6-08daa525a259
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 09:57:08.2054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 gomEq+UjQlHRnXy7yfOaQbOXUO6u+4UIt5PwG/fy3TksZACmriNH30XOXS46xyPmTg6nBa4R4wnh84RdYthm1oFiinllqsUf89/KP95S+HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8512
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Oct 2022 09:57:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9613

Hello Phil,

Thank you for getting in touch.

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Phil Warkentin via lists.cip-project.org
> Sent: 30 September 2022 23:04
>=20
> Hi there,
>=20
> This email address was presented at the Embedded Linux Conference 2022,
> please add me to the mail list if it covers UEFI topics.

You can sign up to the mailing list here: https://lists.cip-project.org/g/c=
ip-dev
Please let us know if you have any issues.

Kind regards, Chris

