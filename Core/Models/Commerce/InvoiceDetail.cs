﻿using System;

namespace Core.Models.Commerce
{
    public class InvoiceDetail
    {
        public DateTime InvoiceDate { get; set; }

        public int InvoiceNumber { get; set; }

        public string InvoiceStatus { get; set; }

        public decimal Total { get; set; }
    }
}