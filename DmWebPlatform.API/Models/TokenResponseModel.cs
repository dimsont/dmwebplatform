﻿namespace DmWebPlatform.API.Models
{
    public class TokenResponseModel
    {
        public string Token { get; set; }

        public DateTime Expiration { get; set; }
    }
}
