﻿using System;
using System.Collections.Generic;

namespace TransportService.Models
{
    public partial class Transportevent
    {
        public long Id { get; set; }
        public long TransportId { get; set; }
        public int Places { get; set; }
        public string Type { get; set; } = null!;
        public DateTime? Creationtime { get; set; }

        public virtual Transport Transport { get; set; } = null!;
    }
}
