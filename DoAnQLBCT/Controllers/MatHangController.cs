using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using DoAnQLBCT.Models;

namespace DoAnQLBCT.Controllers
{
    public class MatHangController : Controller
    {
        private QLBCTEntities db = new QLBCTEntities();

        // GET: MatHang
        public ActionResult Index()
        {
            var matHangs = db.MatHangs.Include(m => m.LoaiMH).Include(m => m.NCC);
            return View(matHangs.ToList());
        }

        // GET: MatHang/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MatHang matHang = db.MatHangs.Find(id);
            if (matHang == null)
            {
                return HttpNotFound();
            }
            return View(matHang);
        }

        // GET: MatHang/Create
        public ActionResult Create()
        {
            ViewBag.MaLMH = new SelectList(db.LoaiMHs, "MaLMH", "TenLMH");
            ViewBag.MaNCC = new SelectList(db.NCCs, "MaNCC", "TenNCC");
            return View();
        }

        // POST: MatHang/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaMH,TenMH,SoLuongTon,GiaMH,MoTa,AnhMH,MaLMH,MaNCC")] MatHang matHang)
        {
            if (ModelState.IsValid)
            {
                db.MatHangs.Add(matHang);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MaLMH = new SelectList(db.LoaiMHs, "MaLMH", "TenLMH", matHang.MaLMH);
            ViewBag.MaNCC = new SelectList(db.NCCs, "MaNCC", "TenNCC", matHang.MaNCC);
            return View(matHang);
        }

        // GET: MatHang/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MatHang matHang = db.MatHangs.Find(id);
            if (matHang == null)
            {
                return HttpNotFound();
            }
            ViewBag.MaLMH = new SelectList(db.LoaiMHs, "MaLMH", "TenLMH", matHang.MaLMH);
            ViewBag.MaNCC = new SelectList(db.NCCs, "MaNCC", "TenNCC", matHang.MaNCC);
            return View(matHang);
        }

        // POST: MatHang/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaMH,TenMH,SoLuongTon,GiaMH,MoTa,AnhMH,MaLMH,MaNCC")] MatHang matHang)
        {
            if (ModelState.IsValid)
            {
                db.Entry(matHang).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaLMH = new SelectList(db.LoaiMHs, "MaLMH", "TenLMH", matHang.MaLMH);
            ViewBag.MaNCC = new SelectList(db.NCCs, "MaNCC", "TenNCC", matHang.MaNCC);
            return View(matHang);
        }

        // GET: MatHang/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MatHang matHang = db.MatHangs.Find(id);
            if (matHang == null)
            {
                return HttpNotFound();
            }
            return View(matHang);
        }

        // POST: MatHang/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            MatHang matHang = db.MatHangs.Find(id);
            db.MatHangs.Remove(matHang);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
